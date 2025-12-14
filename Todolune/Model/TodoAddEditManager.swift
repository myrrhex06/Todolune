import Foundation

final class TodoAddEditManager{
    
    public static let shared = TodoAddEditManager()
    
    private init() {}
    
    private var todo: Todo?
    
    private var mode: AddEditMode?
    
    func setTodo(todo: Todo?){
        self.todo = todo
    }
    
    func getTodo() -> Todo?{
        return todo
    }
    
    func setMode(mode: AddEditMode?){
        self.mode = mode
    }
    
    func getMode() -> AddEditMode?{
        return mode
    }
}
