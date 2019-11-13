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
    @IBOutlet weak var auctionImageView: UIImageView!
    
    private var datePicker: UIDatePicker?
    private var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        setupImagePicker()
    }
    
    private func setupImagePicker() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        auctionImageView.isUserInteractionEnabled = true
        auctionImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UIGestureRecognizer) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
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
        if self.datePicker!.date >= Date() {
            view.endEditing(true)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "Date must be greater than current date", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        endDateTextField.text = DateUtils.getDateFormatter().string(from: datePicker.date)
        endDateTextField.textColor = .black
        if datePicker.date < Date() {
            endDateTextField.textColor = .red
        }
        // view.endEditing(true)
    }
}


extension AddAuctionViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return picker.dismiss(animated: true, completion: nil)
        }
        
        self.auctionImageView.image = image
        self.dismiss(animated: false, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = true
        self.dismiss(animated: true, completion: nil)
    }
}
