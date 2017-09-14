//  This file was automatically generated and should not be edited.

import Apollo

public final class AllPostsQuery: GraphQLQuery {
  public static let operationString =
    "query AllPosts {" +
    "  posts {" +
    "    __typename" +
    "    ...PostDetails" +
    "  }" +
    "}"

  public static var requestString: String { return operationString.appending(PostDetails.fragmentString) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("posts", type: .list(.object(Post.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(posts: [Post?]? = nil) {
      self.init(snapshot: ["__typename": "Query", "posts": posts])
    }

    public var posts: [Post?]? {
      get {
        return (snapshot["posts"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Post(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "posts")
      }
    }

    public struct Post: GraphQLSelectionSet {
      public static let possibleTypes = ["Post"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("votes", type: .scalar(Int.self)),
        GraphQLField("author", type: .object(Author.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: Int, title: String? = nil, votes: Int? = nil, author: Author? = nil) {
        self.init(snapshot: ["__typename": "Post", "id": id, "title": title, "votes": votes, "author": author])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return snapshot["id"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var votes: Int? {
        get {
          return snapshot["votes"]! as! Int?
        }
        set {
          snapshot.updateValue(newValue, forKey: "votes")
        }
      }

      public var author: Author? {
        get {
          return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "author")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var postDetails: PostDetails {
          get {
            return PostDetails(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }

      public struct Author: GraphQLSelectionSet {
        public static let possibleTypes = ["Author"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(firstName: String? = nil, lastName: String? = nil) {
          self.init(snapshot: ["__typename": "Author", "firstName": firstName, "lastName": lastName])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var firstName: String? {
          get {
            return snapshot["firstName"]! as! String?
          }
          set {
            snapshot.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return snapshot["lastName"]! as! String?
          }
          set {
            snapshot.updateValue(newValue, forKey: "lastName")
          }
        }
      }
    }
  }
}

public final class RefreshTokenQuery: GraphQLQuery {
  public static let operationString =
    "query RefreshToken {" +
    "  refresh {" +
    "    __typename" +
    "    ...Token" +
    "  }" +
    "}"

  public static var requestString: String { return operationString.appending(Token.fragmentString) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("refresh", type: .object(Refresh.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(refresh: Refresh? = nil) {
      self.init(snapshot: ["__typename": "Query", "refresh": refresh])
    }

    public var refresh: Refresh? {
      get {
        return (snapshot["refresh"]! as! Snapshot?).flatMap { Refresh(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "refresh")
      }
    }

    public struct Refresh: GraphQLSelectionSet {
      public static let possibleTypes = ["Token"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: String) {
        self.init(snapshot: ["__typename": "Token", "id": id])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return snapshot["id"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var token: Token {
          get {
            return Token(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }
    }
  }
}

public final class UpvotePostMutation: GraphQLMutation {
  public static let operationString =
    "mutation UpvotePost($postId: Int!) {" +
    "  upvotePost(postId: $postId) {" +
    "    __typename" +
    "    ...PostDetails" +
    "  }" +
    "}"

  public static var requestString: String { return operationString.appending(PostDetails.fragmentString) }

  public var postId: Int

  public init(postId: Int) {
    self.postId = postId
  }

  public var variables: GraphQLMap? {
    return ["postId": postId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("upvotePost", arguments: ["postId": Variable("postId")], type: .object(UpvotePost.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(upvotePost: UpvotePost? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "upvotePost": upvotePost])
    }

    public var upvotePost: UpvotePost? {
      get {
        return (snapshot["upvotePost"]! as! Snapshot?).flatMap { UpvotePost(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "upvotePost")
      }
    }

    public struct UpvotePost: GraphQLSelectionSet {
      public static let possibleTypes = ["Post"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("votes", type: .scalar(Int.self)),
        GraphQLField("author", type: .object(Author.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: Int, title: String? = nil, votes: Int? = nil, author: Author? = nil) {
        self.init(snapshot: ["__typename": "Post", "id": id, "title": title, "votes": votes, "author": author])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return snapshot["id"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var votes: Int? {
        get {
          return snapshot["votes"]! as! Int?
        }
        set {
          snapshot.updateValue(newValue, forKey: "votes")
        }
      }

      public var author: Author? {
        get {
          return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "author")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var postDetails: PostDetails {
          get {
            return PostDetails(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }

      public struct Author: GraphQLSelectionSet {
        public static let possibleTypes = ["Author"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(firstName: String? = nil, lastName: String? = nil) {
          self.init(snapshot: ["__typename": "Author", "firstName": firstName, "lastName": lastName])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var firstName: String? {
          get {
            return snapshot["firstName"]! as! String?
          }
          set {
            snapshot.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return snapshot["lastName"]! as! String?
          }
          set {
            snapshot.updateValue(newValue, forKey: "lastName")
          }
        }
      }
    }
  }
}

public struct PostDetails: GraphQLFragment {
  public static let fragmentString =
    "fragment PostDetails on Post {" +
    "  __typename" +
    "  id" +
    "  title" +
    "  votes" +
    "  author {" +
    "    __typename" +
    "    firstName" +
    "    lastName" +
    "  }" +
    "}"

  public static let possibleTypes = ["Post"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(Int.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("votes", type: .scalar(Int.self)),
    GraphQLField("author", type: .object(Author.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: Int, title: String? = nil, votes: Int? = nil, author: Author? = nil) {
    self.init(snapshot: ["__typename": "Post", "id": id, "title": title, "votes": votes, "author": author])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: Int {
    get {
      return snapshot["id"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  public var title: String? {
    get {
      return snapshot["title"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "title")
    }
  }

  public var votes: Int? {
    get {
      return snapshot["votes"]! as! Int?
    }
    set {
      snapshot.updateValue(newValue, forKey: "votes")
    }
  }

  public var author: Author? {
    get {
      return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "author")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes = ["Author"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("firstName", type: .scalar(String.self)),
      GraphQLField("lastName", type: .scalar(String.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(firstName: String? = nil, lastName: String? = nil) {
      self.init(snapshot: ["__typename": "Author", "firstName": firstName, "lastName": lastName])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    public var firstName: String? {
      get {
        return snapshot["firstName"]! as! String?
      }
      set {
        snapshot.updateValue(newValue, forKey: "firstName")
      }
    }

    public var lastName: String? {
      get {
        return snapshot["lastName"]! as! String?
      }
      set {
        snapshot.updateValue(newValue, forKey: "lastName")
      }
    }
  }
}

public struct Token: GraphQLFragment {
  public static let fragmentString =
    "fragment Token on Token {" +
    "  __typename" +
    "  id" +
    "}"

  public static let possibleTypes = ["Token"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(String.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: String) {
    self.init(snapshot: ["__typename": "Token", "id": id])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return snapshot["id"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }
}