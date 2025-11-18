import UIKit

final class ViewController: UIViewController {
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupTableView()
    }
    
    func setupNavigation(){
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
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
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        cell.selectionStyle = .none
        cell.createdAtLabel.text = "yesterday"
        cell.todoTitleLabel.text = "Buy milk"
        
        return cell
    }
}
