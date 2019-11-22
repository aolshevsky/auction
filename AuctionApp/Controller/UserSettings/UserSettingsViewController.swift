//
//  UserSettingsViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/23/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    let menuSettings: [String] = ["Общая информация", "Изменение пароля", "Пополнение счета"]
    let settingViewControllers = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.closeBackButtonPressed))
    }
    
    private func setupActiveAuctionsTableView() {
           settingsTableView.register(UINib(nibName: "UserSettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "UserSettingsTableViewCell")
           settingsTableView.delegate = self
           settingsTableView.dataSource = self
       }
    
    @objc func closeBackButtonPressed(){
        self.dismiss(animated: false, completion: nil)
    }
}

extension UserSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuSettings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserSettingsTableViewCell") as! UserSettingsTableViewCell
        cell.setSetting(setting: self.menuSettings[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let setting = self.menuSettings[indexPath.section]
        let vc =
        let vc = AuctionInfoViewController(nibName: "AuctionInfoViewController", bundle: nil)
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
        vc.commonInit(auction: auction)
    }
}
