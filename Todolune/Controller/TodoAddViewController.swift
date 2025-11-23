import UIKit

class TodoAddViewController: UIViewController {

    let todoAddView = TodoAddView()
    
    override func loadView() {
        self.view = todoAddView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoAddView.setTextFieldDelegate(delegate: self)
        todoAddView.setTextViewDelegate(delegate: self)
        setupNavigation()
    }
    
    func setupNavigation(){
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.title = "New Task"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
