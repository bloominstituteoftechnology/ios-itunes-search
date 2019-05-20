import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var mediaType: UISegmentedControl!
    
    @IBOutlet weak var searchField: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        self.tableView.reloadData()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchField.text, !searchTerm.isEmpty else { return }
        var resultType: ResultType!
        let segment = mediaType.selectedSegmentIndex
        
        switch segment {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        default:
            resultType = .movie
        }
        
        SearchResultController.performSearch(with: searchTerm, resultType: resultType) { (searchResults, error) in
            if let error = error {
                NSLog("Error fetching results: \(error)")
                return
            }
            
            self.searchResultsController.searchResults = searchResults ?? []
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = searchResultsController.searchResults.count
        return rowCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath) as? SearchResultTableViewCell else {
            fatalError("Unable to deque cell")
        }

        // Configure the cell...
        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.artistLabel?.text = result.creator
        cell.titleLabel?.text = result.title
        return cell
        
    }
    

   

}
