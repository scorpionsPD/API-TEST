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
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
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
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            completion(imageFromCache)
        }
        else{
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                if let image = UIImage(data: data){
                    self.imageCache.setObject(image, forKey: url as AnyObject)
                    completion(image)
                }
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
