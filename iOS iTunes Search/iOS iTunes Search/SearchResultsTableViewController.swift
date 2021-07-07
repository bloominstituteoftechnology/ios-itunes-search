
import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    
    // constant whose value is an new instance of SearchResultController
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            else { return }
        
        // This will hold the result type selected from the segmented control
        var resultType: ResultType!
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = ResultType.apps
        case 1:
            resultType = ResultType.music
        default:
            resultType = ResultType.movies
            
        }
        
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("Attempted to search")
        }
    }

    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    // Cell contents
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        
        // Get the result by indexPath
        let searchResultObject = searchResultsController.searchResults[indexPath.row]
        
        // fill out the cell labels
        cell.textLabel?.text = searchResultObject.title
        cell.detailTextLabel?.text = searchResultObject.creator

        return cell
    }
}
