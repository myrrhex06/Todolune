import UIKit

final class TodoAddViewController: UIViewController {

    let todoAddView = TodoAddView()
    
    let coreDataManager = CoreDataManager.shared
    
    var delegate: TodoAddViewControllerDelegate?
    
    // MARK: - UI 구성
    override func loadView() {
        self.view = todoAddView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTodoAddView()
        setupNavigation()
    }
    
    func setupTodoAddView(){
        todoAddView.setTextFieldDelegate(delegate: self)
        todoAddView.setTextViewDelegate(delegate: self)
        todoAddView.setSubmitButtonTarget(target: self, selector: #selector(submitButtonTapped))
    }
    
    func setupNavigation(){
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.title = "New Task"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        coreDataManager.createTodo(title: title, description: description)
        
        delegate?.saveSuccessTodo()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - TextView Delegate
extension TodoAddViewController: UITextViewDelegate{

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
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimateSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { constraint in
            
            guard estimateSize.height > 150 && estimateSize.height < 250 else { return }
            
            if(constraint.firstAttribute == .height){
                constraint.constant = estimateSize.height
            }
        }
    }
}

// MARK: - TextField Delegate
extension TodoAddViewController: UITextFieldDelegate{
    
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
}
