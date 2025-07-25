//
//  LoginViewController.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/7/25.
//

import UIKit
import Combine
import SwiftUI

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    @IBAction func signInAction(_ sender: UIButton) {

        print("Sign In button tapped!")
        let username = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if username.isEmpty {
            let alert = UIAlertController(
                title: "Missing Information",
                message: "Please enter username",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if password.isEmpty {
            let alert = UIAlertController(
                title: "Missing Information",
                message: "Please enter password.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        UserDefaults.standard.set(true, forKey: "isLoggedIn")

        let tabBarVC = MainTabBarController()
        self.navigationController?.setViewControllers([tabBarVC], animated: true)
        print("Username: \(username), Password: \(password)")

//        let vc = UIHostingController(rootView: LoginSwiftUIView())
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func rememberMeButton(_ sender: Any) {
    }
    
    func setupTextField() {

        let grayColor = UIColor.gray.withAlphaComponent(0.7)

        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [.foregroundColor: grayColor]
        )

        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [.foregroundColor: grayColor]
        )
    }
}

@IBDesignable
class RoundedTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = .lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        clipsToBounds = true
    }
}
