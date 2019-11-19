//
//  Request.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/19/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


struct RequestResult {
    var code: Int?
    var message: String
    var status: String
    var result: [[String: Any]]
    
    init(code: Int?, message: String, status: String, result: [[String: AnyObject]]) {
        self.code = code
        self.message = message
        self.status = status
        self.result = result
    }
}

class Request {
    
    static let inst: Request = Request()
    
    let hostName: String = "https://25f7648b.ngrok.io"
    var token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzZjhiZDYwYy0zYzM1LTQ0ZjgtOGQ4MS0wNzA3MDAxOTNmOWYiLCJ1bmlxdWVfbmFtZSI6ImFkbWluIiwianRpIjoiMjQ0ODY4N2ItZTI2Yi00ZjA2LTk0NjMtZWYwMGQyYjUwMjYyIiwiaWF0IjoiMTEvMTkvMjAxOSAyMTo1ODowNCIsIm5iZiI6MTU3NDIwMDY4NCwiZXhwIjoxNjEwMjAwNjg0LCJpc3MiOiJNZSIsImF1ZCI6IkF1ZGllbmNlIn0.A1viwWpPGcsyaFiaZcVqv-CdsUk9MYwNIs1OwPolaRU"
    
    func initToken(username: String, password: String) {
        let params = ["username": username, "password": password]
        let url: String = "\(hostName)/api/auth/token"
        DispatchQueue.main.async {
            self.httpRequest(url: url, params: params, httpMethod: "POST", isAuth: false, completion: { (data) in
                let json = self.parseRequestData(data: data)
                print("Token: ", json!)
                if let json = json {
                    self.token = json.result[0]["token"] as! String
                    print("INIT TOKEN: ", self.token)
                }
            })
        }
    }
    
    private func getBearerAuthHeader() -> String {
        return "Bearer \(token)"
    }
    
    private init () {
        initToken(username: "admin", password: "123qweA!")
    }
    
    func parseRequestData(data: Data, debug: Bool=false) -> RequestResult? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if debug == true {
                print("Response: ", json)
            }
            var resultJson: [[String: AnyObject]]?
            if let result = (json["result"] as? [String: AnyObject]) {
                resultJson = [result]
            } else {
                resultJson = (json["result"] as! [[String: AnyObject]])
            }
            return RequestResult(code: (json["code"] as! Int), message: json["message"] as! String, status: json["status"] as! String, result: resultJson!)
        } catch {
            print("Error")
            return nil
        }
    }
     
    private func createRequestBody(params: [String: String]) -> Data {
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return Data()}
        return httpBody
    }
    
    func getRequest(url: String, isAuth: Bool=true, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: url) else { return completion(Data()) }
        var request = URLRequest(url: url)
        
        if isAuth {
            request.setValue(getBearerAuthHeader(), forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
            guard let data = data,
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            error == nil else { return completion(Data())}

            return completion(data)
        }.resume()
    }
    
    func httpRequest(url: String, params: [String: String], httpMethod: String = "POST", isAuth: Bool=true, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: url) else { return completion(Data())}
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = createRequestBody(params: params)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if isAuth {
            request.setValue(getBearerAuthHeader(), forHTTPHeaderField: "Authorization")
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
//           if let response = response {
//               print(response)
//           }
           guard let data = data,
           let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
           error == nil else { return completion(Data())}

           return completion(data)
        }.resume()
    }
}
