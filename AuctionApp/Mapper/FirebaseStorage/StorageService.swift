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

    static func uploadImage(image: UIImage, at reference: StorageReference, completion: @escaping (String?) -> ()) {

        var resUrl: URL?
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return completion(nil)
        }
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                print("Download url:", url as Any)
                resUrl = url
                completion(resUrl?.absoluteString)
            })
        })
    }
    
    static func downloadImage(imageView: UIImageView, reference: StorageReference) {
        reference.getData(maxSize: 10000, completion: { (data, error) in
            if error != nil {
                print(" we couldn't upload the img")
            } else {
                if let imgData = data,let img = UIImage(data: imgData) {
                    imageView.image = img
                }
            }
        })
}
}

