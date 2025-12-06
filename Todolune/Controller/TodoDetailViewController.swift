import UIKit

final class TodoDetailViewController: UIViewController {

    // MARK: - 할일 세부 사항 확인 뷰
    private let detailView = TodoDetailView()
    
    // MARK: - UI 구성
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        setNavigation()
    }
    
    func setNavigation(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "Task Detail"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .done, target: self, action: #selector(touchUpEditButton))
    }
    
    func setTodo(todo: Todo?){
        detailView.setTodo(todo: todo)
    }
    
    @objc func touchUpEditButton(){
        print(#function)
    }
    
}
