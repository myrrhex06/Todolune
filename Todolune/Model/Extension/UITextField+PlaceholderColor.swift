import UIKit

extension UITextField{
    
    func setPlaceholderColor(color: UIColor){
        guard let placeholder = self.placeholder else { return }
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
