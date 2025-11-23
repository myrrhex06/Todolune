import UIKit

class TodoAddView: UIView {
    
    // MARK: - 할일 제목 텍스트 필드
    private let todoTitleTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = UIColor(named: "textFieldColor")
        textField.text = Constant.TITLE_PLACEHOLDER
        textField.textColor = .createdDate
        
        textField.font = UIFont.systemFont(ofSize: 17)
        
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.3
        
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        
        textField.setPadding()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    // MARK: - 할일 세부 사항(또는 메모) 텍스트 뷰
    let todoDescriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 7, bottom: 15, right: 7)
        
        textView.backgroundColor = UIColor(named: "textFieldColor")
        
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = Constant.DESCRIPTION_PLACEHOLDER
        textView.textColor = .createdDate
        
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 0.3
        
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 8
        
        textView.isScrollEnabled = false
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
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
        setupTodoDescriptionTextView()
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
    
    func setupTodoDescriptionTextView(){
        self.addSubview(todoDescriptionTextView)
        
        NSLayoutConstraint.activate([
            todoDescriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            todoDescriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            todoDescriptionTextView.topAnchor.constraint(equalTo: todoTitleTextField.bottomAnchor, constant: 50),
            todoDescriptionTextView.heightAnchor.constraint(equalToConstant: 150)
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
    
    func setTextViewDelegate(delegate: UITextViewDelegate){
        todoDescriptionTextView.delegate = delegate
    }
    
    func setTextFieldDelegate(delegate: UITextFieldDelegate){
        todoTitleTextField.delegate = delegate
    }
}
