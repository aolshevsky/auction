//
//  SearchViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/3/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    func getAuctionsByCategory(category: String) -> [Auction]? {
        switch category {
        case AuctionStatus.opened.rawValue:
            return self.openAuctions
        case AuctionStatus.closed.rawValue:
            return self.closedAuctions
        case "All":
            return self.openAuctions + self.closedAuctions
        default:
            print("Unhandler search category: ", category)
            return nil
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let category = searchBar.scopeButtonTitles![selectedScope]
        searchBar.text = ""
        self.showAuctions = getAuctionsByCategory(category: category)!
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let category = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        guard !searchText.isEmpty else {
            self.showAuctions = getAuctionsByCategory(category: category)!
            self.tableView.reloadData()
            return
        }
        self.showAuctions = DataSource.shared.filterAuctions(auctions: getAuctionsByCategory(category: category)!, searchText: searchText.lowercased())
        self.tableView.reloadData()
    }
}


class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var openAuctions: [Auction] = []
    var closedAuctions: [Auction] = []
    var showAuctions: [Auction] = []
    private let refreshControl = UIRefreshControl()
    
    let notificationCenter = NotificationCenter.default
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "AuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionTableViewCell")
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshAuctionsData), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Auction Data...", attributes: nil)
    }
    
    @objc func refreshAuctionsData() {
        self.searchBar.selectedScopeButtonIndex = 1
        fetchOpenAuctions()
        fetchClosedAuctions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshAuctionsData()
    }
    
    func fetchClosedAuctions() {
        RequestBuilder.shared.getAuctions(status: AuctionStatus.closed.rawValue) { (auctions) in
            self.closedAuctions = DataSource.shared.markAuctionAsFavorite(auctions: auctions)
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchOpenAuctions() {
        RequestBuilder.shared.getAuctions(status: AuctionStatus.opened.rawValue) { (auctions) in
            self.openAuctions = DataSource.shared.markAuctionAsFavorite(auctions: auctions)
            self.showAuctions = self.openAuctions
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return showAuctions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let auction = showAuctions[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionTableViewCell") as! AuctionTableViewCell
        cell.setAuction(auction: auction)
        
        // Cell UI
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.2
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let auction = showAuctions[indexPath.section]
        let vc = AuctionInfoViewController(nibName: "AuctionInfoViewController", bundle: nil)
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
        vc.commonInit(auction: auction)
    }
}
