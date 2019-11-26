//
//  FinalRegisterViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/25/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class FinalRegisterViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var cardNumberTF: UITextField!
    @IBOutlet weak var registerBtn: UIButton!

    private var datePicker: UIDatePicker?
    private var imagePicker = UIImagePickerController()
    private var isSetImage: Bool = false
    private var registerData: RegisterValidation!

    override func viewDidLoad() {
        super.viewDidLoad()
        styleInit()
        setupDatePicker()
        setupImagePicker()
        setupRegisterGestures()
    }

    func setupRegister(registerValid: RegisterValidation) {
        self.registerData = registerValid
    }

    private func validateChangedInfo() -> Bool {
        if let firstName = firstNameTF.text, let lastName = lastNameTF.text, let birthday = birthdayTF.text, let address = addressTF.text, let phone = phoneTF.text, let card = cardNumberTF.text, card.isEmpty || firstName.isEmpty || lastName.isEmpty || birthday.isEmpty || address.isEmpty || phone.isEmpty || !self.isSetImage {
               displayAlertMessage(vc: self, message: "Все поля должны быть заполенены")
               return false
           }
        return true
    }

    private func setupRegisterGestures() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedRegisgter))
           tapGesture.numberOfTapsRequired = 1
           self.registerBtn.addGestureRecognizer(tapGesture)
       }

    @objc func tappedRegisgter() {
        if !validateChangedInfo() { return }
        self.showSpinner(onView: self.view)
        PostStorage.uploadImage(for: imageView.image!, child: DbConstant.getUserPath(id: registerData.username), completion: { (imageUrl) in
            let senderUser = SenderUser(email: self.registerData.email, passwordConfirmation: self.registerData.passwordConfirmation, birthday: self.birthdayTF.text!, address: self.addressTF.text!, firstName: self.firstNameTF.text!, lastName: self.lastNameTF.text!, phoneNumber: self.phoneTF.text!, imageUrl: imageUrl, username: self.registerData.username, password: self.registerData.password, cardNumber: self.cardNumberTF.text!)
            RequestBuilder.shared.authRegister(user: senderUser) { (data) in
                if data.code == 200 {
                    let login = Login(username: self.registerData.username, password: self.registerData.password)
                    RequestBuilder.shared.getToken(login: login, completion: { (data) in
                        if data.code == 200 {
                            print("Register user with username: ", self.registerData.username)
                            Token.setupToken(token: data.result!.token)
                            self.toMenuPage()
                        }
                    })
                } else {
                    DispatchQueue.main.async {
                        displayAlertMessage(vc: self, message: data.message)
                        print("User not registered")
                        self.removeSpinner()
                    }
                }
            }
        })
    }

    private func styleInit() {
        UIStyle.applyCornerRadius(view: self.imageView, radius: 10)
        UIStyle.applyCornerRadius(view: self.registerBtn, radius: 10)
    }

    private func toMenuPage() {
        RequestBuilder.shared.getProfile { (data) in }
        RequestBuilder.shared.getAuctions { (auctions) in }
        RequestBuilder.shared.getAllUsers()
        RequestBuilder.shared.getAllFavorites(completion: { (auctions) in
            print("Favorite auctions count: ", auctions.count)
            DispatchQueue.main.async {
                self.removeSpinner()
                self.mainMenuRedirect()
            }
        })
    }

    private func mainMenuRedirect() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let vc =  storyboard.instantiateInitialViewController() as? UITabBarController

        if let vc = vc {
            present(vc, animated: false)
        }
    }
}


extension FinalRegisterViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return picker.dismiss(animated: true, completion: nil)
        }

        self.imageView.image = image
        self.dismiss(animated: false, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = true
        self.dismiss(animated: true, completion: nil)
    }
}


extension FinalRegisterViewController {
    // Setup image picker
    private func setupImagePicker() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func imageTapped(tapGestureRecognizer: UIGestureRecognizer) {
        let alert = UIAlertController(title: "Выберетите способ", message: nil, preferredStyle: .actionSheet)
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


extension FinalRegisterViewController {
    // Setup date picker
    private func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        datePicker?.date = Calendar.current.date(byAdding: .year, value: -UserConstant.minAge, to: Date())!

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
