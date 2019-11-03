//
//  BaseAuth.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/3/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation
import UIKit

func displaySuccessMessage(vc: UIViewController, message: String) {
    let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
        mainMenuRedirect(baseVC: vc)
    }
    
    alert.addAction(okAction);
    vc.present(alert, animated: true, completion: nil);
}

func displayAlertMessage(vc: UIViewController, message: String) {
    let alert = UIAlertController(title: "Attention!", message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
    
    alert.addAction(okAction);
    vc.present(alert, animated: true, completion: nil);
}

func mainMenuRedirect(baseVC: UIViewController) {
    let storyboard = UIStoryboard(name: "Menu", bundle: nil)
    let vc =  storyboard.instantiateInitialViewController() as? MenuViewController
    if let vc = vc {
        vc.modalPresentationStyle = .fullScreen
        baseVC.present(vc, animated: true)
    }
}
