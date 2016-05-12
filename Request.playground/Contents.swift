import Request
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

struct Post : Initializable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

GET<[Post]>("http://jsonplaceholder.typicode.com/posts").success(200) { response, request in
    for post in response.body {
        print(post)
    }
}.failure { error, request in
    print(error)
}.begin()


