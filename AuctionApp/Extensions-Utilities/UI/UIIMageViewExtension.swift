//
//  UIIMageViewExtension.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/16/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

let imageCache = NSCache<StringKey, UIImage>()

final class StringKey : NSObject {
    
    let string: String
    
    init(string: String) {
        self.string = string
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? StringKey else {
            return false
        }
        return string == other.string
    }
    
    override var hash: Int {
        return string.hashValue
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: StringKey(string: url.absoluteString)) {
            self.image = cachedImage
            return
        }
        
        // new download
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let _ = response?.mimeType,
                let data = data, error == nil,
                let downloadImage = UIImage(data: data)
                else {
                    print("Can't load image")
                    return }
            DispatchQueue.main.async() {
                imageCache.setObject(downloadImage, forKey: StringKey(string: url.absoluteString))
                print("Image successfully loaded")
                self.image = downloadImage
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
