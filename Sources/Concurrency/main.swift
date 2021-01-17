import _Concurrency
import Foundation
import Dispatch

//func login(userName: String, password: String) async -> String {
//    print("Trying to get token")
//    sleep(2)
//    return await withUnsafeContinuation({ continuation in
//        login(userName: userName, password: password) { token in
//            continuation.resume(returning: token)
//        }
//    })
//}

struct LoginError: Error {}

func login(userName: String, password: String) async throws -> String {
    print("Trying to get token")
    sleep(2)
    return try await withUnsafeThrowingContinuation({ continuation in
        if password != "1" {
            let error = LoginError()
            continuation.resume(throwing: error)
            return
        }
        login(userName: userName, password: password) { token in
            continuation.resume(returning: token)
        }
    })
}

@asyncHandler func getToken() {
    guard let token = try? await login(userName: "cagan", password: "1") else { return }
    print(token)
}


func login(userName: String, password: String, completion: @escaping (String) -> Void) {
    sleep(2)
    completion("1")
}

func loadSections() async -> [String] {
    print("Trying to get sections")
    sleep(1)
    print("Sections loaded")
    return ["Section 1", "Section 2", "Section 3", "Section 4"]
}

runAsyncAndBlock {
    print("-------START-------")
    guard let token = try? await login(userName: "cagan", password: "1") else { return }

    if !token.isEmpty {
        let sections = await loadSections()
        print(sections)
    }
}
print("--------END--------")
