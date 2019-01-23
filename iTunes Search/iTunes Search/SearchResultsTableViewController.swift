import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    // Made a constant, despite the fact that we're only calling on it once.
    let reuseIdentifier = "ResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        
        // App/Song/Movie name should be in the title.
        cell.textLabel?.text = searchResult.title
        // The creator/company/author name should be provided in the details.
        cell.detailTextLabel?.text = searchResult.creator
        
        guard let url = URL(string: searchResult.artwork),
            let imageData = try? Data(contentsOf: url) else { return cell }
        
        cell.imageView?.image = UIImage(data: imageData)
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        let segmentIndex = segmentedControl.selectedSegmentIndex
        
        var resultType: ResultType!

        // Doesn't appear to need .rawValue() appended at the end.
        switch segmentIndex {
        case 0:
            resultType = .apps
        case 1:
            resultType = .songs
        default:
            resultType = .movies
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { _, _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
