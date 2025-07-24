import UIKit
import SwiftUI

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

//    let teachers: [Teacher] = []
//    let viewModel: TeacherViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegate to intercept tab taps
        self.delegate = self
        let reservedTeachers = ReservedTeacherManager.shared.getReservedTeachers()
        let totalCoins = ReservedTeacherManager.shared.getTotalReservedCoin()

//        let favorites = teachers.filter {
//            UserDefaults.standard.isFavorite(id: $0.id ?? 0)
//        }

        let firstVC = TeacherListViewController()
        let swiftUIView = TeacherReservedSwiftUIView(
            reservedTeachers: reservedTeachers,
            totalReservedCoin: totalCoins
        )
//        let favoritesVC = TeacherFavoritesSwiftUIView(
//                viewModel: viewModel,
//                favoriteTeachers: favorites
//        )

        let dummyVC = UIViewController()
        dummyVC.view.backgroundColor = .systemBackground

        let nav1 = UINavigationController(rootViewController: firstVC)
        let nav2 = UIHostingController(rootView: swiftUIView)
        //let nav3 = UIHostingController(rootView: favoritesVC)
        let nav4 = UINavigationController(rootViewController: dummyVC)

        nav1.tabBarItem = UITabBarItem(title: "Teachers", image: UIImage(systemName: "house"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "Reservation List", image: UIImage(systemName: "calendar"), tag: 0)
        //nav3.tabBarItem = UITabBarItem(title: "Favorite Teachers", image: UIImage(systemName: "heart.filled"), tag: 0)
        nav4.tabBarItem = UITabBarItem(title: "Logout", image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), tag: 2)

        viewControllers = [nav1,nav2,nav4]
    }

    // Intercept tab bar taps
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let index = viewControllers?.firstIndex(of: viewController), index == 2 {
            showLogoutConfirmation()
            return false // prevent switching to this tab
        }
        return true
    }

    private func showLogoutConfirmation() {
        let alert = UIAlertController(
            title: "Logout",
            message: "Are you sure you want to log out?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            // Clear UserDefaults
            UserDefaults.standard.set(false, forKey: "isLoggedIn")

            // Navigate back to Login
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            let navController = UINavigationController(rootViewController: loginVC)

            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = navController
            }
        }))

        present(alert, animated: true, completion: nil)
    }
}
