import UIKit

final class TodoAddEditViewController: UIViewController {

    // MARK: - 할일 추가 화면
    private let todoAddView = TodoAddView()
    
    // MARK: - CoreData
    private let coreDataManager = CoreDataManager.shared
    
    // MARK: - Delegate
    var addDelegate: TodoAddDelegate?
    
    // MARK: - Delegate
    var editDelegate: TodoEditDelegate?
    
    private var todo: Todo?
    
    // MARK: - UI 구성
    override func loadView() {
        self.view = todoAddView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        setupTodoAddView()
        
        if todo != nil {
            print("Edit")
            setupEditViewNavigation()
        }else{
            print("Add")
            setupAddViewNavigation()
        }
    }
    
    func setupTodoAddView(){
        todoAddView.setTextFieldDelegate(delegate: self)
        todoAddView.setTextViewDelegate(delegate: self)
        todoAddView.setSubmitButtonTarget(target: self, selector: #selector(submitButtonTapped))
    }
    
    func setupAddViewNavigation(){
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.title = "New Task"
    }
    
    func setupEditViewNavigation(){
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.title = "Edit Task"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setTodo(todo: Todo?){
        self.todo = todo
        todoAddView.setEditTodoData(todo: todo)
    }
    
    @objc func submitButtonTapped(){
        
        guard let title = todoAddView.getTodoTitle(), title != Constant.TITLE_PLACEHOLDER else {
            
            let alert = UIAlertController(title: "Message", message: "Enter a title", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            
            present(alert, animated: true)
            
            return
        }
        
        guard let description = todoAddView.getTodoDescription(), description != Constant.DESCRIPTION_PLACEHOLDER else {
            
            let alert = UIAlertController(title: "Message", message: "Enter a description", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            
            present(alert, animated: true)
            
            return
        }
        
        print(#function)
        
        if let todo = todo {
            let title = todoAddView.getTodoTitle()
            let description = todoAddView.getTodoDescription()
            
            todo.todoTitle = title
            todo.todoDescription = description
            
            coreDataManager.updateTodo(parameterTodo: todo)
            
            editDelegate?.editSuccessTodo(todo: todo)
            
            print("Update 성공")
        }else{
            print("else문")
            
            coreDataManager.createTodo(title: title, description: description)
            
            addDelegate?.saveSuccessTodo()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - TextView Delegate
extension TodoAddEditViewController: UITextViewDelegate{

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constant.DESCRIPTION_PLACEHOLDER {
            textView.text = nil
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            textView.text = Constant.DESCRIPTION_PLACEHOLDER
            textView.textColor = .createdDate
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        guard let text = textView.text else { return }
        
        let count = text.count
        
        if count > Constant.TODO_DESCRIPTION_MAX_LENGTH {
            let prefix = String(text.prefix(Constant.TODO_DESCRIPTION_MAX_LENGTH))
            
            textView.text = prefix
        }
        
        todoAddView.setDescriptionCount(count: textView.text.count)
    }
}

// MARK: - TextField Delegate
extension TodoAddEditViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == Constant.TITLE_PLACEHOLDER {
            textField.text = nil
            textField.textColor = .white
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            textField.text = Constant.TITLE_PLACEHOLDER
            textField.textColor = .createdDate
            
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return false }
        
        let length = text.utf16.count + string.utf16.count - range.length
        
        todoAddView.setTodoCount(count: length)
        
        if let char = string.cString(using: .utf8){
            let isBackspace = strcmp(char, "\\b")
            
            if isBackspace == -92 {
                return true
            }
        }
        
        if length >= Constant.TODO_TITLE_MAX_LENGTH{
            return false
        }
        
        return true
    }
}
