//
//  TeacherDetailsViewController.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/8/25.
//

import UIKit

class TeacherDetailsViewController: UIViewController {

    var teacher: Teacher?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = teacher?.name ?? ""

        // Do any additional setup after loading the view.
    }

}
