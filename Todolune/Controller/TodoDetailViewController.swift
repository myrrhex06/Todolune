import UIKit

final class TodoDetailViewController: UIViewController {

    // MARK: - 할일 세부 사항 확인 뷰
    private let detailView = TodoDetailView()
    
    // MARK: - Todo Manager
    private let todoManager = TodoManager.shared
    
    // MARK: - Todo Detail Manager
    private let todoDetailManager = TodoDetailManager.shared
    
    // MARK: - Delegate
    var editDelegate: TodoEditDelegate?
    
    // MARK: - UI 구성
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        detailView.addTarget(target: self, selector: #selector(touchUpCompletedButton))
        
        setNavigation()
    }
    
    func setNavigation(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "Task Detail"
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .done, target: self, action: #selector(touchUpEditButton))
    }
    
    func setTodo(todo: Todo?){
        todoDetailManager.setTodo(todo: todo)
        detailView.setTodoData(todo: todoDetailManager.getTodo())
    }
    
    @objc func touchUpEditButton(){
        
        let todoEditVc = TodoAddEditViewController()
        
        todoEditVc.setTodo(todo: todoDetailManager.getTodo())
        todoEditVc.setMode(mode: .edit)
        
        todoEditVc.editDelegate = self
        
        self.navigationController?.pushViewController(todoEditVc, animated: true)
    }
    
    @objc func touchUpCompletedButton(){
        guard let todo = todoDetailManager.getTodo() else { return }
        
        todo.isCompleted.toggle()
        todoDetailManager.setTodo(todo: todo)
        
        todoManager.updateTodo(todo: todo)
        
        detailView.setTodoData(todo: todo)
        
        editDelegate?.editSuccessTodo(todo: todo)
    }
}

// MARK: - TodoAddEditViewController Delegate
extension TodoDetailViewController: TodoEditDelegate{
    
    func editSuccessTodo(todo: Todo) {
        todoDetailManager.setTodo(todo: todo)
        detailView.setTodoData(todo: todo)
        editDelegate?.editSuccessTodo(todo: todo)
    }
}
