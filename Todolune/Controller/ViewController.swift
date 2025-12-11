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
        setupTodoData()
        setupTableView()
        setupTodoPlusButton()
    }
    
    func setupTodoData(){
        todoManager.clearTodo()
        
        todoManager.setOffset(offset: 0)
        todoManager.setLimit(limit: 10)
        
        guard let todos = todoManager.fetchTodos() else { return }
        
        todoManager.appendTodoList(todos: todos)
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
        
        vc.setMode(mode: .add)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 테이블뷰 DataSource
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let todoList = todoManager.getTodoList()
        
        if todoList.count == 0 {
            tableView.setupEmptyView(message: "Your task list is empty.")
        }else{
            tableView.removeEmptyView()
        }
        
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        let todoList = todoManager.getTodoList()
        
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
            
            let todos = self.todoManager.getTodoList()
            
            let todo = todos[indexPath.row]
            
            guard let uuid = todo.todoId else { return }
            
            self.todoManager.deleteTodo(uuid: uuid)
            var todoList = self.todoManager.getTodoList()
            todoList.remove(at: indexPath.row)
            self.todoManager.setTodoList(todoList: todoList)
            
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
        
        let todoList = todoManager.getTodoList()
        let todo = todoList[indexPath.row]
        
        vc.setTodo(todo: todo)
        vc.editDelegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !todoManager.getIsDataEnded(){
            
            let offsetY = scrollView.contentOffset.y
            let height = scrollView.contentSize.height
            
            if offsetY > height - scrollView.bounds.height {
                
                let limit = todoManager.getLimit()
                let offset = todoManager.getOffset()
                
                let nextOffset = offset + limit
                
                todoManager.setOffset(offset: nextOffset)
                todoManager.setLimit(limit: limit)
                
                guard let todos = todoManager.fetchTodos() else { return }
                
                if todos.isEmpty {
                    
                    todoManager.setLimit(limit: limit)
                    todoManager.setOffset(offset: offset)
                    
                    todoManager.setIsDataEnded(isDataEnded: true)
                    
                    return
                }
                
                todoManager.appendTodoList(todos: todos)
                
                tableView.reloadData()
                
                todoManager.setIsDataEnded(isDataEnded: false)
            }
        }
    }
}

// MARK: - TodoAddViewController Add Delegate
extension ViewController: TodoAddDelegate{
    
    func saveSuccessTodo() {
        todoManager.clearTodo()
        
        todoManager.setLimit(limit: 10)
        todoManager.setOffset(offset: 0)
        todoManager.setIsDataEnded(isDataEnded: false)
        
        guard let todos = todoManager.fetchTodos() else { return }
        
        todoManager.appendTodoList(todos: todos)
        
        tableView.reloadData()
    }
}

// MARK: - TodoAddViewController Edit Delegate
extension ViewController: TodoEditDelegate{
    
    func editSuccessTodo(todo: Todo) {
        todoManager.clearTodo()
        
        todoManager.setLimit(limit: 10)
        todoManager.setOffset(offset: 0)
        todoManager.setIsDataEnded(isDataEnded: false)
        
        guard let todos = todoManager.fetchTodos() else { return }
        
        todoManager.appendTodoList(todos: todos)
        
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
