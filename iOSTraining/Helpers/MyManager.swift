//
//  MyManager.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/11/25.
//

import Foundation

final class MyManager {
    static let shared = MyManager()
    private(set) var isLoggedIn : Bool = false

    private init() {
        setIsLoggedIn(true)
    }

    func doSomething() {
        print("Singleton doing something")
    }

    func setIsLoggedIn(_ isLoggedIn: Bool){
        self.isLoggedIn = isLoggedIn
    }
}
