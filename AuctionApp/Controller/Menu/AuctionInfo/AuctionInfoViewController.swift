//
//  AuctionInfoViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/9/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class AuctionInfoViewController: UIViewController {

    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var createdDateTextField: UILabel!
    @IBOutlet weak var statusTextField: UILabel!
    //@IBOutlet weak var descriptionTextField: UILabel!
    @IBOutlet weak var startPriceTextField: UILabel!
    @IBOutlet weak var creatorTextField: UILabel!
    @IBOutlet weak var endPriceTextField: UILabel!
    @IBOutlet weak var purchasedByTextField: UILabel!
    @IBOutlet weak var endDateTextField: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeBetButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var creatorTableView: UITableView!
    
    var vcAuction: Auction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        creatorTableView.register(UINib(nibName: "CreatorTableViewCell", bundle: nil), forCellReuseIdentifier: "CreatorTableViewCell")
        creatorTableView.delegate = self;
        creatorTableView.dataSource = self;
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBet))
        tapGesture.numberOfTapsRequired = 1
        self.placeBetButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tappedBet() {
        let vc = PlaceBetViewController(nibName: "PlaceBetViewController", bundle: nil)
        vc.commonInit(auction: self.vcAuction)
        vc.modalPresentationStyle = .popover
        let popOverVC = vc.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.placeBetButton
        popOverVC?.sourceRect = CGRect(x: self.placeBetButton.bounds.midX, y: self.placeBetButton.bounds.minY, width: 0, height: self.placeBetButton.bounds.height)
        vc.preferredContentSize = CGSize(width: 230, height: 230)
        self.present(vc, animated: true)
    }    
    
    func commonInit(auction: Auction) {
        self.vcAuction = auction
        self.titleTextField.text = auction.title
        self.createdDateTextField.text = DateUtils.dateToString(date: auction.createDate)
        self.endDateTextField.text = DateUtils.dateToString(date: auction.endDate)
        self.statusTextField.text = auction.status.rawValue
        self.descriptionTextView.text = auction.description
        self.startPriceTextField.text = NumberUtils.convertFloatPriceToString(value: auction.startPrice)
        self.endPriceTextField.text = NumberUtils.convertFloatPriceToString(value: auction.endPrice)
        self.creatorTextField.text = "linked"
        self.purchasedByTextField.text = "linked"
        self.imageView.downloaded(from: auction.imageUrl)
        
        styleInit()
    }
    
    private func styleInit() {
        UIStyle.applyCornerRadius(view: self.placeBetButton, radius: 5)
        UIStyle.applyBaseLabelStyle(label: self.titleTextField, size: 22)
        UIStyle.applyBaseLabelStyle(label: self.statusTextField, size: 16)
        UIStyle.applyBaseLabelStyle(label: self.startPriceTextField, size: 17, color: .lightGray)
        UIStyle.applyCornerRadius(view: self.imageView, radius: 20)
        //resizeDescriptionViewFrame()
    }
    
    func resizeDescriptionViewFrame() {
        //self.descriptionTextView?.delegate = self
        
        let fixedWidth = self.descriptionTextView.frame.size.width
        let newSize: CGSize = self.descriptionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        var newFrame = self.descriptionTextView.frame
        newFrame.size = CGSize(width: CGFloat(fmaxf((Float(newSize.width)), Float(fixedWidth))), height: newSize.height)
        self.descriptionTextView.frame = newFrame
    }
}

extension AuctionInfoViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension AuctionInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = User(email: "olshevsky.aleksey@gmail.com", name: "Aleksey", surname: "Olshevsky", phone: "228", age: 20, cardNumber: "12-12-12")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreatorTableViewCell") as! CreatorTableViewCell
        cell.setUser(user: user)
        
        // Cell UI
//        cell.layer.borderColor = UIColor.lightGray.cgColor
//        cell.layer.borderWidth = 0.3
//        cell.layer.cornerRadius = 25
//        cell.clipsToBounds = true
        return cell
    }
}
