import UIKit

class TodoCell: UITableViewCell {
    
    let isCompletedCheckbox: CheckboxButton = {
        let btn = CheckboxButton(type: .custom)

        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        let checkImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuration)
        let uncheckImage = UIImage(systemName: "circle", withConfiguration: configuration)
        
        btn.setBackgroundImage(uncheckImage, for: .normal)
        btn.tintColor = UIColor(named: "yellowColor")
        
        btn.toggleHandler = { isSelected in
            if isSelected{
                btn.setBackgroundImage(checkImage, for: .normal)
            }else{
                btn.setBackgroundImage(uncheckImage, for: .normal)
            }
        }
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let todoTitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let createdAtLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [isCompletedCheckbox, todoTitleLabel, createdAtLabel])
        
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor(named: "backgroundColor")
        
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupStackView(){
        
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            isCompletedCheckbox.widthAnchor.constraint(equalToConstant: 20),
            isCompletedCheckbox.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
