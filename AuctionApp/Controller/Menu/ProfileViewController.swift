//
//  ProfileViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/11/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activeAuctionsTableView: UITableView!
    
    var allAuctions: [Auction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleInit()
        self.allAuctions = DataSource.sharedInstance.allAuctions
        setupActiveAuctionsTableView()
    }
    
    private func setupActiveAuctionsTableView() {
        activeAuctionsTableView.register(UINib(nibName: "ActiveUserAuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "ActiveUserAuctionTableViewCell")
        activeAuctionsTableView.delegate = self
        activeAuctionsTableView.dataSource = self
    }
    
    private func styleInit() {
        UIStyle.applyCornerRadius(view: self.imageView, radius: 75)
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allAuctions.count
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .white
//        return view
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Get from database
        let auction = allAuctions[indexPath.section]
        let cell = activeAuctionsTableView.dequeueReusableCell(withIdentifier: "ActiveUserAuctionTableViewCell") as! ActiveUserAuctionTableViewCell
        cell.setUserAuction(auction: auction)
        return cell
    }
}
