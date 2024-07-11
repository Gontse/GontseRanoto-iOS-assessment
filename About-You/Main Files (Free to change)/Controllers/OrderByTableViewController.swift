import UIKit

enum OrderByFilter: String, CaseIterable {
  case years = "Years"
  case coffee = "Coffees"
  case bugs = "Bugs"
}

final class OrderByTableViewController: UITableViewController {

  var didSetOrderbyFilter: ((OrderByFilter) -> Void)?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return OrderByFilter.allCases.count
    }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
    else { return UITableViewCell() }
    cell.textLabel?.text = OrderByFilter.allCases[indexPath.row].rawValue
    return cell
  }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
      didSetOrderbyFilter?(OrderByFilter.allCases[indexPath.row])
    }
}
