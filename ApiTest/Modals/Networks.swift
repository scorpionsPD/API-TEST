//
//  Networks.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 25/02/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import Foundation
import UIKit
class NetworkHandler: NSObject {
    
class var sharedInstance:NetworkHandler{
        struct Singleton {
            static let instance = NetworkHandler()
        }
        return Singleton.instance
    }
    
    func getResponce(requestURL:String,complition:@escaping(_ responce:Data) -> (Void)) {
        let request = URLRequest.init(url: URL(string: requestURL)!)
        URLSession.shared.dataTask(with: request) { (getData, resData, ifError) in
            if ifError == nil{
                complition(getData!)
            }
        }.resume()
    }
    func downloadImage(from url: URL, completion: @escaping (UIImage) ->()) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            if let image = UIImage(data: data){
                completion(image)
            }
            
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
