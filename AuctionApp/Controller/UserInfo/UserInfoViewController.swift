//
//  UserInfoViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/19/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var buyAuctionCount: UILabel!
    @IBOutlet weak var createdAuctionTableView: UITableView!
    
    var allAuctions: [Auction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allAuctions = DataSource.sharedInstance.allAuctions
        styleInit()
        setupCreatedAuctionTableView()
    }
    
    private func styleInit() {
        UIStyle.applyBaseLabelStyle(label: self.emailLabel, size: 17)
        UIStyle.applyBaseLabelStyle(label: self.buyAuctionCount, size: 17)
        UIStyle.applyCornerRadius(view: self.imageView, radius: 60)
    }
    
    func setupUser(user: User) {
        self.fullNameLabel.text = user.getFullName()
        self.emailLabel.text = user.email
        // TODO: count up
        self.buyAuctionCount.text = String(6)
        self.imageView.image = user.image
    }
    
    private func setupCreatedAuctionTableView() {
        createdAuctionTableView.register(UINib(nibName: "ActiveUserAuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "ActiveUserAuctionTableViewCell")
        createdAuctionTableView.delegate = self
        createdAuctionTableView.dataSource = self
    }
}

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == createdAuctionTableView {
            return 1
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == createdAuctionTableView {
            return allAuctions.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Get from database
        if tableView == createdAuctionTableView {
            let auction = allAuctions[indexPath.section]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveUserAuctionTableViewCell") as! ActiveUserAuctionTableViewCell
            cell.setUserAuction(auction: auction)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var auction: Auction!
        if tableView == createdAuctionTableView {
            auction = allAuctions[indexPath.section]
        }
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = AuctionInfoViewController(nibName: "AuctionInfoViewController", bundle: nil)
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
        vc.commonInit(auction: auction)
    }
}
