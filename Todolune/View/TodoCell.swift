import UIKit

class TodoCell: UITableViewCell {
    
    lazy var isCompletedCheckbox: CheckboxButton = {
        let btn = CheckboxButton(type: .custom)

        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        let checkImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuration)
        let uncheckImage = UIImage(systemName: "circle", withConfiguration: configuration)
        
        btn.setBackgroundImage(uncheckImage, for: .normal)
        btn.tintColor = UIColor(named: "yellowColor")
        
        btn.toggleHandler = { isSelected in
            if isSelected{
                btn.setBackgroundImage(checkImage, for: .normal)
                self.toggleLabelStrikeThrough(isCompleted: isSelected)
            }else{
                btn.setBackgroundImage(uncheckImage, for: .normal)
                self.toggleLabelStrikeThrough(isCompleted: isSelected)
            }
        }
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let todoTitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(named: "todoTitleColor")
        label.font = UIFont.systemFont(ofSize: 18)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let createdAtLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(named: "createdDateColor")
        
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
            
            isCompletedCheckbox.widthAnchor.constraint(equalToConstant: 30),
            isCompletedCheckbox.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func toggleLabelStrikeThrough(isCompleted: Bool){
        if isCompleted{
            todoTitleLabel.textColor = UIColor(named: "completedColor")
            todoTitleLabel.attributedText = todoTitleLabel.text?.strikeThrough()
            
            createdAtLabel.textColor = UIColor(named: "completedColor")
            createdAtLabel.attributedText = createdAtLabel.text?.strikeThrough()
        }else{
            todoTitleLabel.textColor = UIColor(named: "todoTitleColor")
            todoTitleLabel.attributedText = todoTitleLabel.text?.unStrikeThrough()
            
            createdAtLabel.textColor = UIColor(named: "createdDateColor")
            createdAtLabel.attributedText = createdAtLabel.text?.unStrikeThrough()
        }
    }
}
