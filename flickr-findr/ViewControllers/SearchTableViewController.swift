//
//  SearchTableViewController.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/19/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    private var photosContainer: PhotosContainer?
    private let tableViewReuseIdentifier = SearchResultTableViewCell.nibName
    private var photos: [Photo]? {
        return photosContainer?.photos
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpSearchBar()
    }
    
    // MARK: - Setup
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: tableViewReuseIdentifier, bundle: nil), forCellReuseIdentifier: tableViewReuseIdentifier)
        tableView.rowHeight = 100
    }
    
    private func setUpSearchBar() {
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .gray
        searchBar.backgroundColor  = .black
        searchBar.placeholder = "Search for photos!"
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        searchBar.delegate = self
        // searchController.searchResultsUpdater = self
        // searchController.dimsBackgroundDuringPresentation = false
        // searchController.hidesNavigationBarDuringPresentation = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewReuseIdentifier, for: indexPath) as! SearchResultTableViewCell
        cell.photo = photos?[indexPath.row]
        return cell
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else { return }
        search(withQuery: searchQuery)
    }
    
    private func search(withQuery searchQuery: String) {
        let photosResource = PhotosResource(searchTerm: searchQuery)
        let photosRequest = ApiRequest(resource: photosResource)
        photosRequest.load { [weak self] photosContainer in
            self?.photosContainer = photosContainer
            self?.tableView.reloadData()
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
