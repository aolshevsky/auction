//
//  CardViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/23/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var currentMoneyLB: UILabel!
    @IBOutlet weak var betMoneyTF: UITextField!
    @IBOutlet weak var betMoneyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelBtn()
        setupBetMoneyGestures()
        setupCurrentMoney()
        styleInit()
    }
    
    private func setupCancelBtn() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.closeBackButtonPressed))
    }
    
    private func setupBetMoneyGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBetMoney))
        tapGesture.numberOfTapsRequired = 1
        self.betMoneyBtn.addGestureRecognizer(tapGesture)
    }
    
    private func setupCurrentMoney() {
        currentMoneyLB.text = NumberUtils.convertFloatPriceToString(value: DataSource.shared.currentUser.balance)
    }
    
    private func styleInit() {
        UIStyle.applyCornerRadius(view: self.betMoneyBtn)
    }
    
    @objc func tappedBetMoney() {
        let balance = DataSource.shared.currentUser.balance
        let betValue = NumberUtils.convetStringToFloat(value: betMoneyTF.text)
        if let betValue = betValue, Int(betValue) > UserConstant.maxBalanceBet {
            displayAlertMessage(vc: self, message: "Максимальная сумма на которую можно увеличить баланс за одну транзакцию составляет: \(UserConstant.maxBalanceBet) $")
            return
        }
        if let betValue = betValue, !betValue.isZero {
            DataSource.shared.updateUserBalance(cardBalance: CardBalance(income: betValue))
            currentMoneyLB.text = NumberUtils.convertFloatPriceToString(value: balance+betValue)
            betMoneyTF.text = ""
            
        } else {
            displayAlertMessage(vc: self, message: "Поле должно быть заполнено")
        }
    }
    
    @objc func closeBackButtonPressed(){
           self.dismiss(animated: false, completion: nil)
    }
}
