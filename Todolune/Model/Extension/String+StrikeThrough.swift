import UIKit

extension String{
    
    func strikeThrough() -> NSAttributedString{
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func unStrikeThrough() -> NSAttributedString{
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(.strikethroughStyle, value: [], range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
