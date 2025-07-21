//
//  CustomUIView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/8/25.
//

import UIKit

@IBDesignable
class CustomUIView: UIView {
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }

  @IBInspectable var borderColor: UIColor = .clear {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }

  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }

    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = false
    }
}

class CustomUIImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
}

class CustomButtonView: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
}


class CustomLabel: UILabel {

    // Border color
    @IBInspectable var borderColor: UIColor = .clear {
        didSet { updateBorders() }
    }

    // Corner radius
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }

    // Border side toggles
    @IBInspectable var showTopBorder: Bool = false { didSet { updateBorders() } }
    @IBInspectable var showLeftBorder: Bool = false { didSet { updateBorders() } }
    @IBInspectable var showRightBorder: Bool = false { didSet { updateBorders() } }
    @IBInspectable var showBottomBorder: Bool = false { didSet { updateBorders() } }

    // Border widths
    @IBInspectable var topBorderWidth: CGFloat = 0 { didSet { updateBorders() } }
    @IBInspectable var leftBorderWidth: CGFloat = 0 { didSet { updateBorders() } }
    @IBInspectable var rightBorderWidth: CGFloat = 0 { didSet { updateBorders() } }
    @IBInspectable var bottomBorderWidth: CGFloat = 0 { didSet { updateBorders() } }

    // Layers
    private var topBorder = CALayer()
    private var leftBorder = CALayer()
    private var rightBorder = CALayer()
    private var bottomBorder = CALayer()

    override func layoutSubviews() {
        super.layoutSubviews()
        updateBorders()
    }

    private enum BorderEdge {
        case top, left, right, bottom
    }

    private func updateBorders() {
        applyBorder(topBorder, visible: showTopBorder, width: topBorderWidth, edge: .top)
        applyBorder(leftBorder, visible: showLeftBorder, width: leftBorderWidth, edge: .left)
        applyBorder(rightBorder, visible: showRightBorder, width: rightBorderWidth, edge: .right)
        applyBorder(bottomBorder, visible: showBottomBorder, width: bottomBorderWidth, edge: .bottom)
    }

    private func applyBorder(_ layer: CALayer, visible: Bool, width: CGFloat, edge: BorderEdge) {
        layer.removeFromSuperlayer()
        guard visible, width > 0 else { return }

        switch edge {
        case .top:
            layer.frame = CGRect(x: 0, y: 0, width: frame.width, height: width)
        case .left:
            layer.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
        case .right:
            layer.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
        case .bottom:
            layer.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
        }

        layer.backgroundColor = borderColor.cgColor
        self.layer.addSublayer(layer)
    }
}
