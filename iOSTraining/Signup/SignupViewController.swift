//
//  SignupViewController.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/8/25.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Signup"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
        
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"), style:.plain , target: self, action: #selector(onTapSettingsButton)
        )
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func onTapSettingsButton() {
        print("Did tap on settings button")
    }

    @IBAction func onTapDismissButton(_ sender: Any) {
//        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
