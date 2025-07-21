//
//  NavigationExtensions.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/17/25.
//

import UIKit

extension Notification.Name {
    static let navigateBackToProductList = Notification.Name("navigateBackToProductList")
}

extension UINavigationController {
    func popToViewController<T: UIViewController>(ofType type: T.Type, animated: Bool) {
        if let vc = viewControllers.first(where: { $0 is T }) {
            popToViewController(vc, animated: animated)
        }
    }
}


