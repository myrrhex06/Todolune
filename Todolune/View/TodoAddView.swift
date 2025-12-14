import UIKit

final class TodoAddView: UIView {
    
    // MARK: - 할일 제목 최대 입력 가능 글자수 표시 Label
    private let displayTitleCountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "0/\(Constant.TODO_TITLE_MAX_LENGTH)"
        
        label.textColor = .createdDate
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
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
    
    // MARK: - 할일 제목 StackView
    private lazy var todoTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [displayTitleCountLabel, todoTitleTextField])
        
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: - 할일 세부 사항(또는 메모) 텍스트 뷰
    private let todoDescriptionTextView: UITextView = {
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
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    // MARK: - 할일 세부 사항 최대 입력 가능 글자수 표시 Label
    private let displayDescriptionCountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "0/\(Constant.TODO_DESCRIPTION_MAX_LENGTH)"
        
        label.textColor = .createdDate
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - 할일 세부 사항 StackView
    private lazy var todoDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [displayDescriptionCountLabel, todoDescriptionTextView])
        
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var descriptionCount: Int?{
        didSet{
            updateDescriptionCountLabel()
        }
    }
    
    private var titleCount: Int?{
        didSet{
            updateTitleCountLabel()
        }
    }
    
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
    
    private func setupUI(){
        self.backgroundColor = UIColor(named: "backgroundColor")
        
        self.addSubview(todoDescriptionStackView)
        self.addSubview(todoTitleStackView)
        self.addSubview(submitButton)
        
        if UIDeviceUtil.isIphoneSe() {
            
            setupIphoneSeTodoTitleStackView()
            setupIphoneSeTodoDescriptionStackView()
            setupIphoneSeSubmitButton()
        }else {
            
            setupTodoTitleStackView()
            setupTodoDescriptionStackView()
            setupSubmitButton()
        }
    }
    
    private func setupIphoneSeTodoTitleStackView(){
        
        NSLayoutConstraint.activate([
            todoTitleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            todoTitleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            todoTitleStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            
            todoTitleTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupTodoTitleStackView(){
        
        NSLayoutConstraint.activate([
            todoTitleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            todoTitleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            todoTitleStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),

            todoTitleTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupIphoneSeTodoDescriptionStackView(){
        
        NSLayoutConstraint.activate([
            todoDescriptionStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            todoDescriptionStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            todoDescriptionStackView.topAnchor.constraint(equalTo: todoTitleStackView.bottomAnchor, constant: 20),
            
            todoDescriptionTextView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupTodoDescriptionStackView(){
        
        NSLayoutConstraint.activate([
            todoDescriptionStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            todoDescriptionStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            todoDescriptionStackView.topAnchor.constraint(equalTo: todoTitleStackView.bottomAnchor, constant: 20),
            
            todoDescriptionTextView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func setupIphoneSeSubmitButton(){
        
        
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            submitButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupSubmitButton(){
        
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            submitButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setTextViewDelegate(delegate: UITextViewDelegate){
        todoDescriptionTextView.delegate = delegate
    }
    
    func setTextFieldDelegate(delegate: UITextFieldDelegate){
        todoTitleTextField.delegate = delegate
    }
    
    func setSubmitButtonTarget(target: Any?, selector: Selector){
        submitButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func getTodoTitle() -> String?{
        return todoTitleTextField.text
    }
    
    func getTodoDescription() -> String?{
        return todoDescriptionTextView.text
    }
    
    func setDescriptionCount(count: Int?){
        descriptionCount = count
    }
    
    func setTodoCount(count: Int?){
        titleCount = count
    }
    
    private func updateDescriptionCountLabel(){
        displayDescriptionCountLabel.text = "\(descriptionCount ?? 0)/\(Constant.TODO_DESCRIPTION_MAX_LENGTH)"
    }
    
    private func updateTitleCountLabel(){
        displayTitleCountLabel.text = "\(titleCount ?? 0)/\(Constant.TODO_TITLE_MAX_LENGTH)"
    }
    
    func setEditTodoData(todo: Todo?){
        todoTitleTextField.text = todo?.todoTitle
        todoTitleTextField.textColor = .white
        titleCount = todoTitleTextField.text?.count
        
        todoDescriptionTextView.text = todo?.todoDescription
        todoDescriptionTextView.textColor = .white
        descriptionCount = todoDescriptionTextView.text.count
    }
}
