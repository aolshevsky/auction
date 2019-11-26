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
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleInit()
        setupCreatedAuctionTableView()
    }
    
    private func setupAuctions() {
        RequestBuilder.shared.getAuctions(userId: user.id, completion: { (auctions) in
            self.allAuctions = auctions
            DispatchQueue.main.async {
                self.createdAuctionTableView.reloadData()
                self.removeSpinner()
            }
        })
    }
    
    private func styleInit() {
        UIStyle.applyBaseLabelStyle(label: self.emailLabel, size: 17)
        UIStyle.applyBaseLabelStyle(label: self.buyAuctionCount, size: 17)
        UIStyle.applyCornerRadius(view: self.imageView, radius: 60)
    }
    
    func setupUser(user: User) {
        self.showSpinner(onView: self.view)
        self.user = user
        self.fullNameLabel.text = user.getFullName()
        self.emailLabel.text = user.email
        RequestBuilder.shared.getOwnedAuctions(userId: user.id, completion: { (auctions) in
            DispatchQueue.main.async {
                self.buyAuctionCount.text = String(auctions.count)
            }
        })
        self.imageView.downloaded(from: user.imageUrl)
        setupAuctions()
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
        if tableView == createdAuctionTableView {
            let auction = allAuctions[indexPath.section]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveUserAuctionTableViewCell") as! ActiveUserAuctionTableViewCell
            cell.setUserAuction(auction: auction)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}
