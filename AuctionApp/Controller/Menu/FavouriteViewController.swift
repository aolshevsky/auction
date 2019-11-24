//
//  FavouriteViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/10/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var auctions: [Auction] = []
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "AuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionTableViewCell")
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshAuctionsData), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Favorite Auctions...", attributes: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAuctions()
    }
    
    @objc func refreshAuctionsData() {
        fetchAuctions()
    }
    
    func fetchAuctions() {
        auctions = DataSource.shared.allFavouriteAuctions
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
    }
}


extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return auctions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let auction = auctions[indexPath.section]
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
        let auction = auctions[indexPath.section]
        let vc = AuctionInfoViewController(nibName: "AuctionInfoViewController", bundle: nil)
        //vc.commonInit(auction: auction)
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true, completion: nil)
        vc.commonInit(auction: auction)

    }
}
