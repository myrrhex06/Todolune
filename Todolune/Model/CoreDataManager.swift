import UIKit
import CoreData

final class CoreDataManager{
    
    public static let shared = CoreDataManager()
    
    private init(){}
    
    private var context: NSManagedObjectContext{
        get{
            let delegate = UIApplication.shared.delegate as! AppDelegate
            
            return delegate.persistentContainer.viewContext
        }
    }
    
    func fetchTodoList(offset: Int, limit: Int) -> [Todo]?{
        let request = Todo.fetchRequest()
        
        request.fetchOffset = offset
        request.fetchLimit = limit
        
        let sort = NSSortDescriptor(key: "createdDate", ascending: false)
        
        request.sortDescriptors = [sort]
        
        do{
            let data = try context.fetch(request)
            
            return data
        }catch{
            print("에러 발생 \(error)")
        }
        
        return nil
    }
    
    func createTodo(title: String, description: String) {
        let todo = Todo(context: context)
        
        todo.todoId = UUID()
        todo.createdDate = Date()
        todo.isCompleted = false
        todo.todoDescription = description
        todo.todoTitle = title
        
        do{
            try context.save()
        }catch{
            print("에러 발생 \(error)")
        }
    }
    
    func deleteTodo(uuid: UUID){
        let request = Todo.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "todoId", uuid as CVarArg)
        
        do{
            let todos = try context.fetch(request)
            
            guard let todo = todos.first else { return }

            context.delete(todo)
            try context.save()
        }catch{
            print("에러 발생 \(error)")
        }
    }
    
    func updateTodo(parameterTodo: Todo){
        
        guard let uuid = parameterTodo.todoId else { return }
        
        let request = Todo.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "todoId", uuid as CVarArg)
        
        do{
            let todos = try context.fetch(request)
            guard let todo = todos.first else { return }
            
            todo.isCompleted = parameterTodo.isCompleted
            todo.todoDescription = parameterTodo.todoDescription
            todo.todoTitle = parameterTodo.todoTitle
            
            try context.save()
            
        }catch{
            print("에러 발생 \(error)")
        }
    }
}
