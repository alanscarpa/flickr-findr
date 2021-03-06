//
//  SearchTableViewController.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/19/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import UIKit
import SwiftSpinner

class SearchTableViewController: UITableViewController, PastSearchesProtocol, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!

    private let tableViewReuseIdentifier = SearchResultTableViewCell.nibName
    private var pastSearchesTableViewController = PastSearchesTableViewController()
    private var photosContainer: PhotosContainer?
    private var photos: [Photo]? {
        return photosContainer?.photos
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flickr Findr"
        setUpTableView()
        setUpSearchBar()
        setUpPastSearchesTableView()
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
    
    private func setUpPastSearchesTableView() {
        addChild(pastSearchesTableViewController)
        var searchesFrame = tableView.frame
        searchesFrame.size.height = tableView.frame.size.height - searchBar.frame.size.height - navigationController!.navigationBar.frame.size.height
        searchesFrame.origin.y = searchesFrame.origin.y + searchBar.frame.size.height
        pastSearchesTableViewController.view.frame = searchesFrame
        view.addSubview(pastSearchesTableViewController.tableView)
        pastSearchesTableViewController.tableView.layer.zPosition = 1
        pastSearchesTableViewController.didMove(toParent: self)
        pastSearchesTableViewController.delegate = self
        pastSearchesIsHidden(true)
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let searchQuery = searchBar.text else { return }
        guard let photosContainer = photosContainer else { return }
        if isLastRow(indexPath) {
            search(withQuery: searchQuery, page: photosContainer.page + 1, showSpinner: false)
        }
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
        searchBar.endEditing(true)
        DataManager.addSearchTerm(SearchTerm(searchQuery))
        search(withQuery: searchQuery)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard !DataManager.getSearchedTerms().isEmpty else { return }
        pastSearchesIsHidden(false)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        pastSearchesIsHidden(true)
    }
    
    // MARK: - PastSearchesProtocol
    
    func didSelectPastSearch(_ searchQuery: String) {
        pastSearchesIsHidden(true)
        searchBar.text = searchQuery
        searchBar.endEditing(true)
        search(withQuery: searchQuery)
    }
    
    // MARK: - Helpers
    
    private func search(withQuery searchQuery: String, page: Int = 1, showSpinner: Bool = true) {
        guard !searchQuery.isEmpty else { showBlankSearchAlert(); return }
        let photosResource = PhotosResource(searchTerm: searchQuery, page: page)
        let photosRequest = ApiRequest(resource: photosResource)
        if showSpinner { SwiftSpinner.show("Loading") }
        photosRequest.load { [weak self] result in
            SwiftSpinner.hide()
            switch result {
            case .success(let photosContainer):
                self?.updatePhotos(photosContainer)
            case .failure(let error):
                self?.showAlertWithError(error)
            }
            self?.tableView.reloadData()
        }
    }
    
    private func updatePhotos(_ newPhotosContainer: PhotosContainer?) {
        if photosContainer == nil {
            photosContainer = newPhotosContainer
        } else {
            photosContainer?.update(with: newPhotosContainer)
        }
    }
    
    private func pastSearchesIsHidden(_ isHidden: Bool) {
        pastSearchesTableViewController.tableView.reloadData()
        pastSearchesTableViewController.view.isHidden = isHidden
        tableView.isScrollEnabled = isHidden
    }
    
    private func isLastRow(_ indexPath: IndexPath) -> Bool {
        guard let photos = photos else { return false }
        return indexPath.row == photos.count - 1
    }
    
    private func showAlertWithError(_ error: FFError) {
        let alertVC = UIAlertController.createSimpleAlert(withTitle: error.title, message: error.description)
        present(alertVC, animated: true, completion: nil)
    }
    
    private func showBlankSearchAlert() {
        let alertVC = UIAlertController.createSimpleAlert(withTitle: "Uh-oh!", message: "You need to enter a search term!")
        present(alertVC, animated: true, completion: nil)
    }
}
