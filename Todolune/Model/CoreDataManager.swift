import UIKit
import CoreData

final class CoreDataManager{
    
    public static let shared = CoreDataManager()
    
    private var todoList: [Todo]? = []
    
    private init(){}
    
    private var context: NSManagedObjectContext{
        get{
            let delegate = UIApplication.shared.delegate as! AppDelegate
            
            return delegate.persistentContainer.viewContext
        }
    }
    
    func fetchTodoList() {
        let request = Todo.fetchRequest()
        
        let data = try? context.fetch(request)
        todoList = data
    }
    
    func createTodo(title: String, description: String) {
        let todo = Todo(context: context)
        
        todo.todoId = UUID()
        todo.createdDate = Date()
        todo.isCompleted = false
        todo.todoDescription = description
        todo.todoTitle = title
        
        try? context.save()
    }
    
    func deleteTodo(uuid: UUID){
        let request = Todo.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "todoId", uuid as CVarArg)
        
        let todos = try? context.fetch(request)
        
        guard let todo = todos?.first else { return }

        context.delete(todo)
        try? context.save()
    }
    
    func getTodoList() -> [Todo]? {
        return todoList
    }
}
