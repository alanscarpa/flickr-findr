//
//  PastSearchesTableViewController.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/19/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import UIKit

protocol PastSearchesProtocol: class {
    func didSelectPastSearch(_ searchQuery: String)
}

class PastSearchesTableViewController: UITableViewController {

    var pastSearches: [SearchTerm] {
        return DataManager.getSearchedTerms()
    }
    weak var delegate: PastSearchesProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastSearches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = pastSearches[indexPath.row].query
        return cell
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectPastSearch(pastSearches[indexPath.row].query)
    }
}
