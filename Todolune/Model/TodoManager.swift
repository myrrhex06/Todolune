import Foundation

final class TodoManager{
    
    public static let shared = TodoManager()
    
    private init(){}
    
    private let coreDataManager = CoreDataManager.shared
    
    func fetchTodos() -> [Todo]?{
        let todo = coreDataManager.fetchTodoList()
        
        return todo
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
    
}
