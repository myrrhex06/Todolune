import UIKit

class TodoAddView: UIView {
    
    // MARK: - 할일 제목 텍스트 필드
    private let todoTitleTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = UIColor(named: "textFieldColor")
        textField.placeholder = "What needs to be done?"
        textField.setPlaceholderColor(color: .createdDate)
        
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.3
        
        textField.textColor = .white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    // MARK: - 할일 세부 사항(또는 메모) 텍스트 필드
    private let todoDescriptionTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = UIColor(named: "textFieldColor")
        textField.placeholder = "Add details or notes..."
        textField.setPlaceholderColor(color: .createdDate)
        
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.3
        
        textField.textColor = .white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    // MARK: - 제출 버튼
    private let submitButton: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("SAVE", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        btn.backgroundColor = UIColor(named: "signatureYellowColor")
        
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    // MARK: - UI 구성
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupUI(){
        self.backgroundColor = UIColor(named: "backgroundColor")
        
        setupTodoTitleTextField()
        setupTodoDescriptionTextField()
        setupSubmitButton()
    }
    
    func setupTodoTitleTextField(){
        self.addSubview(todoTitleTextField)
        
        NSLayoutConstraint.activate([
            todoTitleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            todoTitleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            todoTitleTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            todoTitleTextField.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setupTodoDescriptionTextField(){
        self.addSubview(todoDescriptionTextField)
        
        NSLayoutConstraint.activate([
            todoDescriptionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            todoDescriptionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            todoDescriptionTextField.topAnchor.constraint(equalTo: todoTitleTextField.bottomAnchor, constant: 50),
            todoDescriptionTextField.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupSubmitButton(){
        self.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -90),
            submitButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
