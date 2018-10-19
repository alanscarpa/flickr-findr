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
        title = "Flickr Finder"
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
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photo = photos?[indexPath.row] else { return }
        searchBar.resignFirstResponder()
        navigationController?.pushViewController(PhotoViewController(photo), animated: true)
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
    
}
