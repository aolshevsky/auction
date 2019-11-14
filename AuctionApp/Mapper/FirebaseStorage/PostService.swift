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
    static func uploadImage(for image: UIImage, child: String) {
        let imageRef = Storage.storage().reference().child(child)
        StorageService.uploadImage(image: image, at: imageRef)
    }
}
