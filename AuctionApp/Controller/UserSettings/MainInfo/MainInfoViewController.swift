//
//  MainInfoViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/23/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit


class MainInfoViewController: UIViewController {
    @IBOutlet weak var firstNameLB: UILabel!
    @IBOutlet weak var secondNameLB: UILabel!
    @IBOutlet weak var birthdayLB: UILabel!
    @IBOutlet weak var addressLB: UILabel!
    @IBOutlet weak var phoneLB: UILabel!
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var secondNameTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var saveChangesBtn: UIButton!
    
    private var datePicker: UIDatePicker?
    private var imagePicker = UIImagePickerController()
    private var isSetImage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.closeBackButtonPressed))
        styleInit()
        setupUser()
        setupDatePicker()
        setupImagePicker()
        setupSaveChangesGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUser()
    }
    
    private func validateChangedInfo()  -> Bool {
        if let firstName = firstNameTF.text, let secondName = secondNameTF.text, let birthday = birthdayTF.text, let address = addressTF.text, let phone = phoneTF.text, firstName.isEmpty || secondName.isEmpty || birthday.isEmpty || address.isEmpty || phone.isEmpty {
               displayAlertMessage(vc: self, message: "All fields are required")
               return false
           }
        return true
    }
    
    private func haveUnSavedInfo() -> Bool {
        let user = DataSource.shared.currentUser
        if let firstName = firstNameTF.text, let secondName = secondNameTF.text, let birthday = birthdayTF.text, let address = addressTF.text, let phone = phoneTF.text, firstName != user?.firstName || secondName != user?.lastName || birthday != DateUtils.dateToString(date: user?.birthday) || address != user?.address || phone != user?.phone || self.isSetImage {
            return true
        }
        return false
    }
    
    private func setupSaveChangesGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSaveChanges))
        tapGesture.numberOfTapsRequired = 1
        self.saveChangesBtn.addGestureRecognizer(tapGesture)
    }
    
    @objc func tappedSaveChanges() {
        if !validateChangedInfo() { return }
        let user = DataSource.shared.currentUser
        user?.firstName = firstNameTF.text!
        user?.lastName = secondNameTF.text!
        user?.birthday = DateUtils.getDateFormatter().date(from: birthdayTF.text!)!
        user?.address = addressTF.text!
        user?.phone = phoneTF.text!
        if self.isSetImage {
            PostStorage.uploadImage(for: userImageView.image!, child: DbConstant.getUserPath(id: user!.id), completion: { (imageUrl) in
                user?.imageUrl = imageUrl
                RequestBuilder.shared.updateProfile(user: user!)
                DataSource.shared.currentUser = user
                DataSource.shared.updateCurrentUser()
            })
        } else {
            RequestBuilder.shared.updateProfile(user: user!)
            DataSource.shared.currentUser = user
            DataSource.shared.updateCurrentUser()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeBackButtonPressed() {
        let alert = UIAlertController(title: "Предупреждение", message: "Присутствуют не сохраненные данные. Желаете сохранить?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Сохранить", style: UIAlertAction.Style.default, handler: { action in
            self.tappedSaveChanges()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: UIAlertAction.Style.destructive, handler: { action in
            self.dismiss(animated: false, completion: nil)
        }))
        
        if self.haveUnSavedInfo() {
            self.present(alert, animated: true, completion: nil)
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func setupUser() {
        let user = DataSource.shared.currentUser
        userImageView.downloaded(from: user!.imageUrl)
        firstNameTF.text = user?.firstName
        secondNameTF.text = user?.lastName
        birthdayTF.text = DateUtils.dateToString(date: user?.birthday)
        addressTF.text = user?.address
        phoneTF.text = user?.phone
    }
        
    private func styleInit() {
        let labels: [UILabel?] = [firstNameLB, secondNameLB, birthdayLB, addressLB, phoneLB]
        UIStyle.applyBaseLabelStyle(labels: labels, size: 18, color: .darkGray, font: "Kohinoor Devanagari")
        UIStyle.applyCornerRadius(view: self.userImageView, radius: 60)
        UIStyle.applyCornerRadius(view: self.saveChangesBtn, radius: 10)
    }
}

extension MainInfoViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return picker.dismiss(animated: true, completion: nil)
        }
        
        self.userImageView.image = image
        self.dismiss(animated: false, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = true
        self.dismiss(animated: true, completion: nil)
    }
}


extension MainInfoViewController {
    // Setup image picker
    private func setupImagePicker() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UIGestureRecognizer) {
        let alert = UIAlertController(title: "Выберетите способо", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Select image
    private func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            self.isSetImage = true
        }
        else
        {
            let alert  = UIAlertController(title: "Предупреждение", message: "У вас нет камеры!", preferredStyle: .alert)
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
        self.isSetImage = true
    }
}


extension MainInfoViewController {
    // Setup date picker
    private func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        datePicker?.date = Date()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        birthdayTF.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UIGestureRecognizer) {
        if self.datePicker!.date <= Calendar.current.date(byAdding: .year, value: -UserConstant.minAge, to: Date())! {
            view.endEditing(true)
        } else {
            let alert  = UIAlertController(title: "Предупреждение", message: "Вы должны быть страше 12 лет", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        dateChanged(datePicker: self.datePicker!)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        birthdayTF.text = DateUtils.getDateFormatter().string(from: datePicker.date)
        birthdayTF.textColor = .black
        if datePicker.date > Calendar.current.date(byAdding: .year, value: -UserConstant.minAge, to: Date())! {
            birthdayTF.textColor = .red
        }
        // view.endEditing(true)
    }
}
