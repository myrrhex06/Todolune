import Foundation

final class TodoDetailManager{
    
    public static let shared = TodoDetailManager()
    
    private init() {}
    
    private var todo: Todo?
    
    func setTodo(todo: Todo?){
        self.todo = todo
    }
    
    func getTodo() -> Todo? {
        return todo
    }
}
