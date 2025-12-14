import UIKit

extension UITextField{
    
    func setPadding(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        self.leftView = paddingView
        self.rightView = paddingView
        
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}
