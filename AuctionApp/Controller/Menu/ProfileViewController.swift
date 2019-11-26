//
//  ProfileViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/11/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UserChangeInfoDelegate {
    
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activeAuctionsTableView: UITableView!
    @IBOutlet weak var closedAuctionsTableView: UITableView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var currentBalance: UILabel!
    
    var activeAuctions: [Auction] = []
    var lastRaiseActiveAuctions: [Auction] = []
    var closedAuctions: [Auction] = []
    var lastRaiseClosedAuctions: [Auction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleInit()
        setupUser()
        setupActiveAuctionsTableView()
        setupClosedAuctionsTableView()
        setupSettingsGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUserInfo()
        
    }
    
    func updateUserInfo() {
        RequestBuilder.shared.getProfile(completion: { (data) in })
        RequestBuilder.shared.getAuctions { (auctions) in
            DispatchQueue.main.async {
                self.setupUser()
            }
        }
    }
    
    func setupUser() {
        let user: User = DataSource.shared.currentUser
        self.imageView.downloaded(from: user.imageUrl)
        self.userFullNameLabel.text = user.getFullName()
        self.currentBalance.text = NumberUtils.convertFloatPriceToString(value: user.balance)
        self.activeAuctions = DataSource.shared.getActiveAuctions(userId: user.id)
        self.lastRaiseActiveAuctions = DataSource.shared.getLastRaiseActiveAuctions(userId: user.id)
        self.closedAuctions = DataSource.shared.getClosedAuctions(userId: user.id)
        self.lastRaiseClosedAuctions = DataSource.shared.getLastRaiseClosedAuctions(userId: user.id)
        self.activeAuctionsTableView.reloadData()
        self.closedAuctionsTableView.reloadData()
    }
    
    private func setupSettingsGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSettings))
        tapGesture.numberOfTapsRequired = 1
        self.settingsButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tappedSettings() {
        let vc = UserSettingsViewController(nibName: "UserSettingsViewController", bundle: nil)
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
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
            return activeAuctions.count
        } else if tableView == closedAuctionsTableView {
            return closedAuctions.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var auction: Auction!
        var lastRaiseAuctions: [Auction]!
        if tableView == activeAuctionsTableView {
            auction = activeAuctions[indexPath.section]
            lastRaiseAuctions = lastRaiseActiveAuctions
        } else if tableView == closedAuctionsTableView {
            auction = closedAuctions[indexPath.section]
            lastRaiseAuctions = lastRaiseClosedAuctions
        }
        let cell = activeAuctionsTableView.dequeueReusableCell(withIdentifier: "ActiveUserAuctionTableViewCell") as! ActiveUserAuctionTableViewCell
        if DataSource.shared.isInCollection(auction: auction, auctions: lastRaiseAuctions) {
            cell.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.05)
        } else {
            cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.05)
        }
//        else if DataSource.shared.isInCollection(auction: auction, auctions: allMyAuctions) {
//            cell.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.05)
//        }
        cell.setUserAuction(auction: auction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var auction: Auction!
        if tableView == activeAuctionsTableView {
            auction = activeAuctions[indexPath.section]
        } else if tableView == closedAuctionsTableView {
            auction = closedAuctions[indexPath.section]
        }
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = AuctionInfoViewController(nibName: "AuctionInfoViewController", bundle: nil)
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
        vc.commonInit(auction: auction)
    }
}
