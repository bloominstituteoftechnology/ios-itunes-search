import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    let searchResultsController = SearchResultController()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return searchResultsController.searchResults.count
    }

    let reuseIdentifier = "cell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let searchResul
        cell.textLabel.text = searchResultsController.searchResults.title

        return cell
    }
    
}
