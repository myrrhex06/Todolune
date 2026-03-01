import UIKit

protocol TodoCellDelegate: AnyObject{
    func completedButtonTapped(cell: TodoCell)
}
