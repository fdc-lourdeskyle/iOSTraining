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
}