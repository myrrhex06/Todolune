import UIKit

class TodoCell: UITableViewCell {
    
    // MARK: - 완료 여부 체크박스
    private lazy var isCompletedCheckbox: CheckboxButton = {
        let btn = CheckboxButton(type: .custom)

        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        let checkImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuration)
        let uncheckImage = UIImage(systemName: "circle", withConfiguration: configuration)
        
        btn.setBackgroundImage(uncheckImage, for: .normal)
        btn.tintColor = UIColor(named: "signatureYellowColor")
        
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
    
    // MARK: - UI 구성
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupUI(){
        self.contentView.backgroundColor = UIColor(named: "backgroundColor")
        
        setupStackView()
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
            
            createdDateLabel.textColor = UIColor(named: "completedColor")
            createdDateLabel.attributedText = createdDateLabel.text?.strikeThrough()
        }else{
            todoTitleLabel.textColor = UIColor(named: "todoTitleColor")
            todoTitleLabel.attributedText = todoTitleLabel.text?.unStrikeThrough()
            
            createdDateLabel.textColor = UIColor(named: "createdDateColor")
            createdDateLabel.attributedText = createdDateLabel.text?.unStrikeThrough()
        }
    }
    
    func setCreatedDateLabelText(text: String?){
        createdDateLabel.text = text
    }
    
    func setTodoTitleLabelText(text: String?){
        todoTitleLabel.text = text
    }
}
