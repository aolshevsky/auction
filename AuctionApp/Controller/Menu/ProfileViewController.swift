//
//  ProfileViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/11/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activeAuctionsTableView: UITableView!
    @IBOutlet weak var closedAuctionsTableView: UITableView!
    
    var allAuctions: [Auction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allAuctions = DataSource.sharedInstance.allAuctions
        styleInit()
        setupUser()
        setupActiveAuctionsTableView()
        setupClosedAuctionsTableView()
    }
    
    func setupUser() {
        // TODO
        // self.imageView.downloaded(from: user.imageUrl)
        let user: User = DataSource.sharedInstance.allUsers[0]
        self.imageView.image = user.image
        self.userFullNameLabel.text = user.getFullName()
    }
    
    private func setupActiveAuctionsTableView() {
        activeAuctionsTableView.register(UINib(nibName: "ActiveUserAuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "ActiveUserAuctionTableViewCell")
        activeAuctionsTableView.delegate = self
        activeAuctionsTableView.dataSource = self
    }
    
    private func setupClosedAuctionsTableView() {
        closedAuctionsTableView.register(UINib(nibName: "ActiveUserAuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "ActiveUserAuctionTableViewCell")
        closedAuctionsTableView.delegate = self
        closedAuctionsTableView.dataSource = self
    }
    
    private func styleInit() {
        UIStyle.applyCornerRadius(view: self.imageView, radius: 50)
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == activeAuctionsTableView {
            return allAuctions.count
        } else if tableView == closedAuctionsTableView {
            return allAuctions.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Get from database
        var auction: Auction!
        if tableView == activeAuctionsTableView {
            auction = allAuctions[indexPath.section]
        } else if tableView == closedAuctionsTableView {
            auction = allAuctions[indexPath.section]
        }
        let cell = activeAuctionsTableView.dequeueReusableCell(withIdentifier: "ActiveUserAuctionTableViewCell") as! ActiveUserAuctionTableViewCell
        cell.setUserAuction(auction: auction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var auction: Auction!
        if tableView == activeAuctionsTableView {
            auction = allAuctions[indexPath.section]
        } else if tableView == closedAuctionsTableView {
            auction = allAuctions[indexPath.section]
        }
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = AuctionInfoViewController(nibName: "AuctionInfoViewController", bundle: nil)
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
        vc.commonInit(auction: auction)
    }
}
