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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI(){
        self.backgroundColor = .background
        
        self.addSubview(todoTitleLabel)
        self.addSubview(createdDateLabel)
        
        setupAutoLayout()
    }
    
    func setupAutoLayout(){
        NSLayoutConstraint.activate([
            todoTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            todoTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            todoTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
            
            createdDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            createdDateLabel.topAnchor.constraint(equalTo: todoTitleLabel.bottomAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setTodo(todo: Todo?){
        todoTitleLabel.text = todo?.todoTitle
        createdDateLabel.text = DateFormatterUtil.dateFormatter.string(from: todo?.createdDate ?? Date())
    }
}
