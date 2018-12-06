import UIKit


class SearchResultsTableViewController: UITableViewController {
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
