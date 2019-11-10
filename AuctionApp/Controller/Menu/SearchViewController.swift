//
//  SearchViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/3/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var auctions: [Auction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auctions = createAuctions()
        tableView.register(UINib(nibName: "AuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionTableViewCell")
    }
    
    func createAuctions() -> [Auction] {
        var tempAuctions: [Auction] = []
        
        let auction1 = Auction(image: #imageLiteral(resourceName: "audi"), title: "Audi TT", price: 450, isStar: false)
        let auction2 = Auction(image: #imageLiteral(resourceName: "bugatti"), title: "Buggati-Veron", price: 4000, isStar: false)
        let auction3 = Auction(image: #imageLiteral(resourceName: "classic"), title: "Тачка деда", price: 100, isStar: false)
        let auction4 = Auction(image: #imageLiteral(resourceName: "merce"), title: "Тачка прадеда", price: 3220, isStar: true)
        let auction5 = Auction(image: #imageLiteral(resourceName: "merce2"), title: "Тачка бабули", price: 890, isStar: false)
        
        tempAuctions.append(auction1)
        tempAuctions.append(auction2)
        tempAuctions.append(auction3)
        tempAuctions.append(auction4)
        tempAuctions.append(auction5)

        
        return tempAuctions
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
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
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let auction = auctions[indexPath.section]
        let vc = AuctionInfoViewController(nibName: "AuctionInfoViewController", bundle: nil)
        //vc.commonInit(auction: auction)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        vc.commonInit(auction: auction)

    }
}
