import UIKit

//func greet(_ person: String, on day: String) -> String {
//    return "Hello \(person), today is \(day)."
//}
//let greetings = greet("John", on: "Wednesday")
//print(greetings)


UserDefaults.standard.set(true, forKey: "isLoggedIn")
UserDefaults.standard.set("LMKC", forKey: "username")
UserDefaults.standard.set(25, forKey: "userAge")

var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
let username = UserDefaults.standard.string(forKey:"username")
let userAge = UserDefaults.standard.integer(forKey:"userAge")

print("\(isLoggedIn)")
print(username ?? "No username")
print("\(userAge)")

UserDefaults.standard.removeObject(forKey: "isLoggedIn")
isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")

print("\(isLoggedIn)")
print(username ?? "No username")
print("\(userAge)")

//final class MyManager {
//    static let shared = MyManager()
//
//    private init() {
//
//    }
//
//    func doSomething() {
//        print("Singleton doing something"')
//    }
//}
