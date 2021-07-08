import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var segmentedBar: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "app", for: indexPath)
        
        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        
        return cell
    }
    
    // MARK - SearchBar Delegate
    
    // create a var to take in the search bar text
    // and check and see guard if its empty
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        var resultType: ResultType!
        
        // use the segmented control to pick which one you want to search for
        let typeSegment = segmentedBar.selectedSegmentIndex
        
        // switch segment in (swith Segment form)
        switch typeSegment {
        case 0:
            resultType = ResultType.software
        case 1:
            resultType = ResultType.music
        case 2:
            resultType = ResultType.movie
        default:
            return
        }
        
        
        // call the performSearch Method
        // pass in the searchTerm and resultType
        //
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { (result, error) in self.searchResultsController.searchResults = result ?? []
            print(self.searchResultsController.searchResults)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.endEditing(true)
            }
        }
        
    }
    
}


