import UIKit

class CheckboxButton: UIButton {
    
    var toggleHandler: ((Bool) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCheckbox()
    }
    
    func setupCheckbox(){
        self.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func checkBoxTapped() {
        isSelected.toggle()
        toggleHandler?(isSelected)
    }
}
