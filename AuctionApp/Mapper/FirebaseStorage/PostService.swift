//
//  PostService.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/14/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation
import FirebaseStorage

struct PostStorage {
    
    static func getImageRef(path: String) -> StorageReference{
        Storage.storage().reference().child(path)
    }
    
    static func uploadImage(for image: UIImage, child: String, completion: @escaping (String) -> ()) {
        DispatchQueue.main.async {
            let imageRef = Storage.storage().reference().child(child)
            StorageService.uploadImage(image: image, at: imageRef, completion: { (url) in
                print("Upload image: ", url as Any)
                completion(url!)
            })
        }
    }
}
