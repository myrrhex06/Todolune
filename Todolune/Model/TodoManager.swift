import Foundation

final class TodoManager{
    
    public static let shared = TodoManager()
    
    private init(){}
    
    private let coreDataManager = CoreDataManager.shared
    
    private var todoList: [Todo] = []
    
    private var offset = 0
    
    private var limit = 10
    
    private var isDataEnded: Bool = false
    
    func fetchTodos() -> [Todo]? {
        guard let todo = coreDataManager.fetchTodoList(offset: offset, limit: limit) else { return nil }
        
        return todo
    }
    
    func clearTodo() {
        todoList = []
    }
    
    func createTodo(title: String, description: String){
        coreDataManager.createTodo(title: title, description: description)
    }
    
    func deleteTodo(uuid: UUID){
        coreDataManager.deleteTodo(uuid: uuid)
    }
    
    func updateTodo(todo: Todo){
        coreDataManager.updateTodo(parameterTodo: todo)
    }
    
    func getTodoList() -> [Todo]{
        return todoList
    }
    
    func appendTodoList(todos: [Todo]?){
        guard let todos = todos else { return }
        
        todoList.append(contentsOf: todos)
    }
    
    func setTodoList(todoList: [Todo]){
        self.todoList = todoList
    }
    
    func getOffset() -> Int{
        return offset
    }
    
    func getLimit() -> Int{
        return limit
    }
    
    func getIsDataEnded() -> Bool{
        return isDataEnded
    }
    
    func setIsDataEnded(isDataEnded: Bool){
        self.isDataEnded = isDataEnded
    }
    
    func setOffset(offset: Int){
        self.offset = offset
    }
    
    func setLimit(limit: Int){
        self.limit = limit
    }
}
