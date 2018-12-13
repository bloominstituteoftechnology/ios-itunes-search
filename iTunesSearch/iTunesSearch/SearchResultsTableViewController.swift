import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        <#code#>
    }
    
    //tableview funcs
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
}

