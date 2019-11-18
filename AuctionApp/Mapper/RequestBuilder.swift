//
//  RequestBuilder.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/19/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


class RequestBuilder {
    
    static let inst: RequestBuilder = RequestBuilder()
    
    private init () {}
    
    func getAllAuctions() {
        let request = Request.inst
        let url: String = "\(request.hostName)/api/auction"
        request.getRequest(url: url, withHeader: true)
        
    }
}
