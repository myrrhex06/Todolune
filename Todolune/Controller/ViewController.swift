import UIKit

final class ViewController: UIViewController {
    
    // MARK: - 테이블뷰
    private let tableView = UITableView()
    
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
        
        setupNavigation()
        setupTableView()
        setupTodoPlusButton()
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
        
        tableView.register(TodoCell.self, forCellReuseIdentifier: "TodoCell")
        
        tableView.rowHeight = 100
        
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
        self.navigationController?.pushViewController(TodoAddViewController(), animated: true)
    }
}

// MARK: - 테이블뷰 DataSource
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        cell.selectionStyle = .none
        cell.createdAtLabel.text = "yesterday"
        cell.todoTitleLabel.text = "Buy Milk"
        
        return cell
    }
}
