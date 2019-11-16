//
//  StorageService.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/14/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation
import FirebaseStorage


struct StorageService {

    static func uploadImage(image: UIImage, at reference: StorageReference) -> URL? {

        var resUrl: URL?
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return nil
        }

        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }

            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }
                //print(url as Any)
                resUrl = url
            })
        })
        return resUrl
    }
    
    static func downloadImage(imageView: UIImageView, reference: StorageReference) {
        reference.getData(maxSize: 10000, completion: { (data, error) in
            if error != nil {
                print(" we couldnt upload the img")
            } else {
                if let imgData = data,let img = UIImage(data: imgData) {
                    imageView.image = img
                }
            }
        })
}
}

