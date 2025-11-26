import UIKit

class TodoDetailViewController: UIViewController {

    private let detailView = TodoDetailView()
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
    }
    
    func setNavigation(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "Task Detail"
    }
    
    func setTodo(todo: Todo?){
        detailView.setTodo(todo: todo)
    }
    
}
