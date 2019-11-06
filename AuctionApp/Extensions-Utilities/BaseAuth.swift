//
//  BaseAuth.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/3/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation
import UIKit


func displayAlertMessage(vc: UIViewController, message: String) {
    let alert = UIAlertController(title: "Attention!", message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
    
    alert.addAction(okAction);
    vc.present(alert, animated: true, completion: nil);
}
