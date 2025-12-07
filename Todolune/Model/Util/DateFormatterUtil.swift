import Foundation

final class DateFormatterUtil{
    
    private init() {}
    
    public static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        
        df.dateStyle = .medium
        df.timeStyle = .none
        df.doesRelativeDateFormatting = true
        
        return df
    }()
}
