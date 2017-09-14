import UIKit
@testable import Apollo

// Change localhost to your machine's local IP address when running from a device
//let apollo = ApolloClient(url: URL(string: "http://localhost:8080/graphql")!)

let apollo = ApolloClient(
    networkTransport: ElmyNetworkTransport(
        url: URL(string: "http://localhost:8080/graphql")!))

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        apollo.cacheKeyForObject = { $0["id"] }
        return true
    }
}

class ElmyNetworkTransport: NetworkTransport {
    let url: URL
    let session: URLSession
    let serializationFormat = JSONSerializationFormat.self
    
    enum State {
        case running
        case waitingForAuth([Request])
        struct Request {
            let callback: (Response?, Error?) -> Void
            let operation: Operation
            
            init<Operation: GraphQLOperation>(operation: Operation, callback: @escaping (GraphQLResponse<Operation>?, Error?) -> Void) {
                self.operation = Request.Operation(
                    operationString: Operation.operationString,
                    requestString: Operation.requestString,
                    operationIdentifier: Operation.operationIdentifier,
                    variables: operation.variables)
                self.callback = { response, error in
                    let response: GraphQLResponse<Operation>? = {
                        guard let response = response else { return nil }
                        return GraphQLResponse<Operation>.init(operation: operation, body: response.body)
                    }()
                    
                    callback(response, error)
                }
            }
            
            struct Operation {
                let operationString: String
                let requestString: String
                let operationIdentifier: String?
                
                let variables: GraphQLMap?
            }
        }
        
        struct Response {
            let body: JSONObject
        }
    }
    
    private var state = State.running {
        didSet {
            print(state)
        }
    }
    
    public init(url: URL, configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.url = url
        self.session = URLSession(configuration: configuration)
    }
    
    private static func request<Operation: GraphQLOperation>(for url: URL, operation: Operation) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["query": type(of: operation).requestString, "variables": operation.variables as Any] as [String : Any]
        request.httpBody = try! JSONSerializationFormat.serialize(value: body)
        request.setValue("1", forHTTPHeaderField: "auth")
        return request
    }
    
    private static func request(for url: URL, from requestObject: State.Request, auth: String = "1") -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["query": requestObject.operation.requestString,
                    "variables": requestObject.operation.variables as Any] as [String : Any]
        request.httpBody = try! JSONSerializationFormat.serialize(value: body)
        request.setValue(auth, forHTTPHeaderField: "auth")
        return request
    }
    
    public func send<Operation: GraphQLOperation>(
        operation: Operation,
        completionHandler: @escaping (GraphQLResponse<Operation>?, Error?) -> Void) -> Cancellable {
        
        switch state {
        case .running: break
        case .waitingForAuth(var requests):
            requests.append(State.Request(operation: operation, callback: completionHandler))
            state = .waitingForAuth(requests)
            return URLSessionDataTask()
        }
        
        let request = ElmyNetworkTransport.request(for: url, operation: operation)
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError("Response should be an HTTPURLResponse")
            }
            
            if (!httpResponse.isSuccessful) {
                // if it is auth error
                if httpResponse.statusCode == 400 {
                    switch self.state {
                    case .running:
                        self.state = .waitingForAuth([.init(operation: operation, callback: completionHandler)])
                        
                        let request = ElmyNetworkTransport.request(for: self.url,
                                                                   operation: RefreshTokenQuery())
                        let task = self.session.dataTask(with: request, completionHandler: { (data, response, error) in
                            guard case .waitingForAuth(let requests) = self.state else { fatalError("Internal state broken!") }
                            self.state = .running
                            
                            guard let httpResponse = response as? HTTPURLResponse else {
                                fatalError("Response should be an HTTPURLResponse")
                            }
                            
                            guard httpResponse.isSuccessful else {
//                                 send errors back to the requests
                                return
                            }
                            guard let auth = httpResponse.allHeaderFields["auth"] as? String else { return }
                            
                            for request in requests {
                                let urlRequest = ElmyNetworkTransport.request(for: self.url, from: request, auth: auth)
                                
                                let task = self.session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                                    guard let data = data else {
                                        request.callback(nil, GraphQLHTTPResponseError(body: nil, response: httpResponse, kind: .invalidResponse))
                                        return
                                    }
                                    do {
                                        guard let body =  try JSONSerializationFormat.deserialize(data: data) as? JSONObject else {
                                            throw GraphQLHTTPResponseError(body: data, response: httpResponse, kind: .invalidResponse)
                                        }
                                        request.callback(ElmyNetworkTransport.State.Response(body: body), error)
                                    } catch {
                                        request.callback(nil, error)
                                    }
                                })
                                task.resume()
                            }
                            
                        })
                        task.resume()
                    case .waitingForAuth(var requests):
                        requests.append(State.Request(operation: operation, callback: completionHandler))
                        self.state = .waitingForAuth(requests)
                    }
                    
                    return
                } else {
                    completionHandler(nil,
                                      GraphQLHTTPResponseError(body: data, response: httpResponse, kind: .errorResponse))
                    return
                }
            }
            
            guard let data = data else {
                completionHandler(nil, GraphQLHTTPResponseError(body: nil, response: httpResponse, kind: .invalidResponse))
                return
            }
            
            do {
                guard let body =  try self.serializationFormat.deserialize(data: data) as? JSONObject else {
                    throw GraphQLHTTPResponseError(body: data, response: httpResponse, kind: .invalidResponse)
                }
                let response = GraphQLResponse(operation: operation, body: body)
                completionHandler(response, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        
        task.resume()
        
        return task
    }
    
    private func requestBody<Operation: GraphQLOperation>(for operation: Operation) -> GraphQLMap {
        return ["query": type(of: operation).requestString, "variables": operation.variables]
    }
}
