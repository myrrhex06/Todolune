import UIKit

class UIDeviceUtil{
    
    private init() {}
    
    public static func getName() -> String{
        
        return UIDevice.current.name
    }
    
    public static func getUuid() -> String{
        
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
}
