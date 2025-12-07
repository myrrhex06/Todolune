import UIKit

final class ViewController: UIViewController {
    
    // MARK: - 테이블뷰
    private let tableView = UITableView()
    
    // MARK: - Todo Manager
    private let todoManager = TodoManager.shared
    
    // MARK: - 할 일 추가 버튼
    private lazy var todoPlusButton: UIButton = {
        let btn = UIButton(type: .custom)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 50)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: configuration)
        
        btn.setBackgroundImage(image, for: .normal)
        btn.tintColor = UIColor(named: "signatureYellowColor")
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(todoPlusButtonTapped), for: .touchUpInside)
        
        return btn
    }()

    // MARK: - UI 구성
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        setupNavigation()
        setupTableView()
        setupTodoPlusButton()
    }
    
    func setupNavigation(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        
        self.title = "Todolune"
    }
    
    func setupTableView(){
        self.view.addSubview(tableView)
        
        tableView.backgroundColor = UIColor(named: "backgroundColor")
        
        tableView.separatorColor = .gray
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TodoCell.self, forCellReuseIdentifier: "TodoCell")
        
        tableView.rowHeight = 80
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
    func setupTodoPlusButton(){
        self.view.addSubview(todoPlusButton)
        
        NSLayoutConstraint.activate([
            todoPlusButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            todoPlusButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
            todoPlusButton.widthAnchor.constraint(equalToConstant: 70),
            todoPlusButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    @objc func todoPlusButtonTapped(){
        let vc = TodoAddEditViewController()
        vc.addDelegate = self
        vc.editDelegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 테이블뷰 DataSource
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let todoList = todoManager.fetchTodos() else {
            tableView.setupEmptyView(message: "Your task list is empty.")
            return 0
        }
        
        if todoList.count == 0 {
            tableView.setupEmptyView(message: "Your task list is empty.")
        }else{
            tableView.removeEmptyView()
        }
        
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        guard let todoList = todoManager.fetchTodos() else { return cell }
        
        let todo = todoList[indexPath.row]
        
        cell.selectionStyle = .none
        
        cell.setTodoData(todo: todo)
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: - 테이블뷰 Delegate
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteButton = UIContextualAction(style: .destructive, title: nil) { _, _, success in
            
            guard let todos = self.todoManager.fetchTodos() else { return }
            
            let todo = todos[indexPath.row]
            
            self.todoManager.deleteTodo(uuid: todo.todoId!)
            
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
            
            success(true)
        }
        
        deleteButton.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteButton])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TodoDetailViewController()
        
        guard let todoList = todoManager.fetchTodos() else { return }
        let todo = todoList[indexPath.row]
        
        vc.setTodo(todo: todo)
        vc.editDelegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TodoAddViewController Add Delegate
extension ViewController: TodoAddDelegate{
    
    func saveSuccessTodo() {
        tableView.reloadData()
    }
}

// MARK: - TodoAddViewController Edit Delegate
extension ViewController: TodoEditDelegate{
    
    func editSuccessTodo(todo: Todo) {
        tableView.reloadData()
    }
}

// MARK: - TodoCell Delegate
extension ViewController: TodoCellDelegate{
    
    func completedButtonTapped(cell: TodoCell) {
        guard let todo = cell.getTodoData() else { return }
        
        todo.isCompleted.toggle()
        
        todoManager.updateTodo(todo: todo)
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
