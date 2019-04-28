

import UIKit

extension UITextField {
    enum Direction {
        case Left
        case Right
    }
    //                      add image to textfield               \\
    func withImage (direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor) {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 8
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)
        
        if Direction.Left == direction { // image left
            seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 45)
            leftViewMode = .always
            leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 45)
            rightViewMode = .always
            rightView = mainView
        }
//        layer.borderColor = colorBorder.cgColor
//        layer.borderWidth = CGFloat(0.5)
//        layer.cornerRadius = 5
    }
    
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0,
                                               width: amount,
                                               height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0,
                                               width: amount,
                                               height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
    
    func setBottomBorder() {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
    }
}
