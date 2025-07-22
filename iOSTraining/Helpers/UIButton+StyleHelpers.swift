//
//  UIButton+StyleHelpers.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/22/25.
//

import Foundation
import UIKit

extension UIButton {

    func applyBottomBorder(isSelected: Bool){

        layer.sublayers?.removeAll(where: {$0.name == "BottomBorder"})

        guard isSelected else { return }

        if isSelected{
            let border = CALayer()
            border.name = "BottomBorder"
            border.backgroundColor = UIColor.orange.cgColor
            border.frame = CGRect(x: 0, y: bounds.height - 2, width: bounds.width, height: 2)
            layer.addSublayer(border)
        }
    }

    func configurePlainButton(_ button: UIButton) {
        let title = button.title(for: .normal) ?? ""

        var config = UIButton.Configuration.plain()
        config.title = title
        config.background.backgroundColor = .clear
        config.baseForegroundColor = .orange// or white if needed
        config.contentInsets = .zero

        button.configuration = config

        button.adjustsImageWhenHighlighted = false
        button.showsTouchWhenHighlighted = false
    }



}
