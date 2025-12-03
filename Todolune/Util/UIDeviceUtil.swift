import UIKit

class UIDeviceUtil{
    
    private init() {}
    
    public static func isIphoneSe() -> Bool{
        let deviceName = UIDevice.current.name
        
        return deviceName.contains("SE")
    }
}
