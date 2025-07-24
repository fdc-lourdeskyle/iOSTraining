//
//  UIButton+StyleHelpers.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/22/25.
//

import Foundation
import UIKit

extension UIButton {

    func applyBottomBorder(isSelected: Bool, borderColor: UIColor = .systemOrange, height: CGFloat = 3) {

        layer.sublayers?.removeAll(where: { $0.name == "bottomBorder" })

        if isSelected {
            let border = CALayer()
            border.name = "bottomBorder"
            border.backgroundColor = borderColor.cgColor
            border.frame = CGRect(x: 0, y: self.bounds.height - height, width: self.bounds.width, height: height)
            self.layer.addSublayer(border)
        }
    }

}
