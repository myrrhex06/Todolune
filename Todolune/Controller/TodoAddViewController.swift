import UIKit

class TodoAddViewController: UIViewController {

    let todoAddView = TodoAddView()
    
    override func loadView() {
        self.view = todoAddView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
