import UIKit


class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    let reuseIdentifier = "cell"
    
    let searchResultsController = SearchResultController()
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        var resultType: ResultType!
        
        if segmentedControl.selectedSegmentIndex == 0 {
            resultType = ResultType.apps
        } else if segmentedControl.selectedSegmentIndex == 1 {
            resultType = ResultType.music
        } else if segmentedControl.selectedSegmentIndex == 2 {
            resultType = ResultType.movies
        }
        
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("attempted to search")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("reached number of rows")
        
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        print("reached cell for at")
        
        return cell
    }
}
