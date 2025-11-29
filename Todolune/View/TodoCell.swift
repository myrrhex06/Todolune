import UIKit

class TodoCell: UITableViewCell {
    
    // MARK: - 완료 여부 체크박스
    private lazy var isCompletedCheckbox: UIButton = {
        let btn = UIButton(type: .custom)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        let checkImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuration)
        let uncheckImage = UIImage(systemName: "circle", withConfiguration: configuration)
        
        btn.setBackgroundImage(uncheckImage, for: .normal)
        btn.tintColor = UIColor(named: "signatureYellowColor")
        
        btn.addTarget(self, action: #selector(isCompletedCheckboxTapped), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    // MARK: - 할일 제목 표시
    private let todoTitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(named: "todoTitleColor")
        label.font = UIFont.systemFont(ofSize: 18)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - 생성 일시 표시
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(named: "createdDateColor")
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - 구성 요소 StackView
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [isCompletedCheckbox, todoTitleLabel, createdDateLabel])
        
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        createdDateLabel.setContentHuggingPriority(.required, for: .horizontal)
        createdDateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        todoTitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        todoTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var todo: Todo?
    
    var delegate: TodoCellDelegate?
    
    // MARK: - UI 구성
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI(){
        self.contentView.backgroundColor = UIColor(named: "backgroundColor")
        
        setupStackView()
    }
    
    private func setupStackView(){
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            isCompletedCheckbox.widthAnchor.constraint(equalToConstant: 30),
            isCompletedCheckbox.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func toggleLabelStrikeThrough(isCompleted: Bool?){
        
        guard let isCompleted = isCompleted else { return }
        
        if isCompleted{
            todoTitleLabel.textColor = UIColor(named: "completedColor")
            todoTitleLabel.attributedText = todoTitleLabel.text?.strikeThrough()
            
            createdDateLabel.textColor = UIColor(named: "completedColor")
            createdDateLabel.attributedText = createdDateLabel.text?.strikeThrough()
        }else{
            todoTitleLabel.textColor = UIColor(named: "todoTitleColor")
            todoTitleLabel.attributedText = todoTitleLabel.text?.unStrikeThrough()
            
            createdDateLabel.textColor = UIColor(named: "createdDateColor")
            createdDateLabel.attributedText = createdDateLabel.text?.unStrikeThrough()
        }
    }
    
    private func setCreatedDateLabelText(text: String?){
        createdDateLabel.text = text
    }
    
    private func setTodoTitleLabelText(text: String?){
        todoTitleLabel.text = text
    }
    
    private func setIsCompletedCheckbox(isOn: Bool){
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        let checkImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuration)
        let uncheckImage = UIImage(systemName: "circle", withConfiguration: configuration)
        
        if isOn{
            isCompletedCheckbox.setBackgroundImage(checkImage, for: .normal)
            self.toggleLabelStrikeThrough(isCompleted: isOn)
        }else{
            isCompletedCheckbox.setBackgroundImage(uncheckImage, for: .normal)
            self.toggleLabelStrikeThrough(isCompleted: isOn)
        }
    }
    
    func setTodoData(todo: Todo){
        self.todo = todo
        
        setTodoTitleLabelText(text: todo.todoTitle)
        setCreatedDateLabelText(text: DateFormatterUtil.dateFormatter.string(from: todo.createdDate ?? Date()))
        setIsCompletedCheckbox(isOn: todo.isCompleted)
    }
    
    func getTodoData() -> Todo?{
        return self.todo
    }
    
    @objc private func isCompletedCheckboxTapped(){
        delegate?.completedButtonTapped(cell: self)
    }
}
