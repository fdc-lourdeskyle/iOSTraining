import UIKit
import SwiftUI

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    private let reservedTeacherListViewModel = ReservedTeacherListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        let firstVC = TeacherListViewController()
        let swiftUIView = TeacherReservedSwiftUIView(viewModel: reservedTeacherListViewModel)

        let dummyVC = UIViewController()
        dummyVC.view.backgroundColor = .systemBackground

        let nav1 = UINavigationController(rootViewController: firstVC)
        let nav2 = UIHostingController(rootView: swiftUIView)
        let nav3 = UINavigationController(rootViewController: dummyVC)

        nav1.tabBarItem = UITabBarItem(title: "Teachers", image: UIImage(systemName: "house"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "Reservation List", image: UIImage(systemName: "calendar"), tag: 0)

        nav3.tabBarItem = UITabBarItem(title: "Logout", image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), tag: 2)

        viewControllers = [nav1,nav2,nav3]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reservedTeacherListViewModel.refresh()
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        reservedTeacherListViewModel.refresh()
    }

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
