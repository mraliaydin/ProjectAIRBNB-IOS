//
//  ViewController.swift
//  ProjectAIRBNB
//
//  Created by Iqbal Karim on 21.12.2022.
//

import UIKit

class HomeVC: UITableViewController {

    let mDataSource = DataSource()
    var places = [Record]()
    var filteredPlaces = [Record]()
    let mSearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mSearchController.searchResultsUpdater = self
    
        tableView.tableHeaderView = mSearchController.searchBar
        
        mSearchController.searchBar.delegate = self
        definesPresentationContext = true
        
        mSearchController.dismiss(animated: true, completion: nil)
        
        mSearchController.searchBar.placeholder = "Search place..."
        mSearchController.searchBar.tintColor = UIColor.white
        mSearchController.searchBar.barTintColor = UIColor.systemPink
        mSearchController.searchBar.scopeButtonTitles = ["All", "House", "Apartment", "Bungalow"]
        
        mDataSource.populate()
        places = mDataSource.getAllItems()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mSearchController.isActive && mSearchController.searchBar.text != "" {
            return filteredPlaces.count
        }
        
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableCell", for: indexPath) as! SearchTVC
        
        let place: Record
        
        // isEmpty can also be used
        if mSearchController.isActive && mSearchController.searchBar.text != "" {
            place = filteredPlaces[indexPath.row]
        }
        else {
            place = places[indexPath.row]
        }
        
        cell.nameView!.text = place.name
        cell.categoryView!.text = place.category
        cell.mImageView!.image = UIImage(named: place.image)
        cell.locationView!.text = place.location
        return cell
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String) {
        filteredPlaces = places.filter({( place : Record) -> Bool in
            let categoryMatch = (scope == "All") || (place.category == scope)
            return ( categoryMatch && place.name.lowercased().contains(searchText.lowercased()) )
        })
        
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let place : Record
                
                if mSearchController.isActive && mSearchController.searchBar.text != "" {
                    place = filteredPlaces[indexPath.row]
                }
                else {
                    place = places[indexPath.row]
                }
                
                let controller = segue.destination as! DetailVC
                controller.mRecord = place
            }
        }
    }
    
}

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension HomeVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        //print(scope)
        filterContentForSearchText(searchController.searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines), scope: scope)
    }
}
