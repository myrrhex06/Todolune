import UIKit

class TodoDetailView: UIView {
    
    // MARK: - 할일 제목 표시
    private let todoTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = .white
        
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - 생성일시 표시
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .createdDate
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Description 문구 표시
    private let displayDescriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Description"
        
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        
        return label
    }()
    
    // MARK: - 할일 세부사항 표시
    private let todoDescriptionLabel: UIVerticalAlignLabel = {
        let label = UIVerticalAlignLabel()
        
        label.textColor = .white
        label.numberOfLines = 0
        
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    // MARK: - 할일 텍스트 StackView
    private lazy var descriptionStackView: UIStackView = {
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
    
    // MARK: - 완료 표시
    private lazy var completedButton: UIButton = {
        let btn = UIButton(type: .custom)

        let configuration = UIImage.SymbolConfiguration(pointSize: 25)
        let checkImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuration)
        let uncheckImage = UIImage(systemName: "circle", withConfiguration: configuration)
        
        btn.setImage(uncheckImage, for: .normal)
        btn.tintColor = UIColor(named: "signatureYellowColor")
        btn.backgroundColor = .textField
        
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        
        btn.isUserInteractionEnabled = false
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    // MARK: - Completed 문구 표시
    private let completedLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        label.text = "Completed"
        
        return label
    }()
    
    // MARK: - 완료 버튼, 레이블 StackView
    private lazy var completedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [completedButton, completedLabel])
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: - UI 구성
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI(){
        self.backgroundColor = .background
        
        setupTodoTitleLabel()
        setupCreatedDateLabel()
        setupCompletedStackView()
        setupDescriptionStackView()
    }
    
    private func setupTodoTitleLabel(){
        self.addSubview(todoTitleLabel)
        
        NSLayoutConstraint.activate([
            todoTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            todoTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            todoTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 120)
        ])
    }
    
    private func setupCreatedDateLabel(){
        self.addSubview(createdDateLabel)
        
        NSLayoutConstraint.activate([
            createdDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            createdDateLabel.topAnchor.constraint(equalTo: todoTitleLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupCompletedStackView(){
        self.addSubview(completedStackView)
        
        NSLayoutConstraint.activate([
            completedButton.widthAnchor.constraint(equalToConstant: 40),
            completedButton.heightAnchor.constraint(equalToConstant: 40),
            
            completedStackView.topAnchor.constraint(equalTo: createdDateLabel.bottomAnchor, constant: 30),
            completedStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            completedStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            completedStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupDescriptionStackView(){
        self.addSubview(descriptionStackView)
        
        NSLayoutConstraint.activate([
            displayDescriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            descriptionStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            descriptionStackView.topAnchor.constraint(equalTo: completedStackView.bottomAnchor, constant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setTodo(todo: Todo?){
        todoTitleLabel.text = todo?.todoTitle
        createdDateLabel.text = DateFormatterUtil.dateFormatter.string(from: todo?.createdDate ?? Date())
        todoDescriptionLabel.text = todo?.todoDescription
        
        guard let todo = todo else { return }
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 25)
        let checkImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuration)
        let uncheckImage = UIImage(systemName: "circle", withConfiguration: configuration)
        
        if todo.isCompleted{
            completedButton.setImage(checkImage, for: .normal)
        }else{
            completedButton.setImage(uncheckImage, for: .normal)
        }
    }
}
