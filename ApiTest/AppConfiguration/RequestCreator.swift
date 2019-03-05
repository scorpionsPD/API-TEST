//
//  RequestCreator.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 25/02/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import Foundation

//let urlRequest = "https://api.foursquare.com/v2/venues/search?near=Delhi&oauth_token=SQ1PQIHAYYDTHK0VJAYUTWM1CJN0XDILXSJG5KOPI045MC1T&v=20160123&limit=10"
let urlRequest = topRatedMoviesURL

class RequestCreator: NSObject {
    class var shared: RequestCreator {
        struct singlton {
            static let instance = RequestCreator()
        }
    return singlton.instance
    }
    func callRequestForMoviesList(complition:@escaping(_ responceModal:MovieList) -> (Void)) {
        NetworkHandler.sharedInstance.getResponce(requestURL: topRatedMoviesURL) { (responceData) in
            let welcome = try? JSONDecoder().decode(MovieList.self, from: responceData)
            complition(welcome!)
        }
    }

}
