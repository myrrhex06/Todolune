import UIKit

class TodoDetailView: UIView {
    
    private let todoTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = .white
        
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .createdDate
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let displayDescriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Description"
        
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        
        return label
    }()
    
    private let todoDescriptionLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.numberOfLines = 0
        
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [displayDescriptionLabel, todoDescriptionLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.backgroundColor = .textField
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI(){
        self.backgroundColor = .background
        
        self.addSubview(todoTitleLabel)
        self.addSubview(createdDateLabel)
        self.addSubview(stackView)
        
        setupAutoLayout()
    }
    
    func setupAutoLayout(){
        NSLayoutConstraint.activate([
            todoTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            todoTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            todoTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
            
            createdDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            createdDateLabel.topAnchor.constraint(equalTo: todoTitleLabel.bottomAnchor, constant: 20),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: self.createdDateLabel.bottomAnchor, constant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setTodo(todo: Todo?){
        todoTitleLabel.text = todo?.todoTitle
        createdDateLabel.text = DateFormatterUtil.dateFormatter.string(from: todo?.createdDate ?? Date())
        todoDescriptionLabel.text = todo?.todoDescription
    }
}
