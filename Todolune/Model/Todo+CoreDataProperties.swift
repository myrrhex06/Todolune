import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var todoId: UUID?
    @NSManaged public var todoTitle: String?
    @NSManaged public var todoDescription: String?
    @NSManaged public var createdDate: Date?

}

extension Todo : Identifiable {

}
