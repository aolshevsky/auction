//
//  AddAuctionViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/13/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class AddAuctionViewController: UIViewController {

    @IBOutlet weak var endDateTextField: UITextField!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }
    
    private func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        endDateTextField.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        endDateTextField.text = DateUtils.getDateFormatter().string(from: datePicker.date)
        // view.endEditing(true)
    }
}
