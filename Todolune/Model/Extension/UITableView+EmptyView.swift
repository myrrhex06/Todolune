import UIKit

extension UITableView{
    
    func setupEmptyView(message: String){
        let emptyView: UIView = UIView(frame: CGRect(x: self.center.x,
                                                     y: self.center.y,
                                                     width: self.bounds.size.width,
                                                     height: self.bounds.size.height))
        
        let messageLabel: UILabel = {
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = message
            label.textColor = .createdDate
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            label.sizeToFit()
            
            return label
        }()
        
        self.addSubview(emptyView)
        
        emptyView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)
        ])
        
        self.backgroundView = emptyView
    }
    
    func removeEmptyView(){
        self.backgroundView = nil
    }
}
