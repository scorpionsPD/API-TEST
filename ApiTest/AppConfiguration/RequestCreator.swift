//
//  RequestCreator.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 25/02/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import Foundation

let urlRequest = moviesInTheaterURL

class RequestCreator: NSObject {
    class var shared: RequestCreator {
        struct singlton {
            static let instance = RequestCreator()
        }
    return singlton.instance
    }
    func callRequestForMoviesList(region:String,complition:@escaping(_ responceModal:MovieList) -> (Void)) {
        NetworkHandler.sharedInstance.getResponce(requestURL: moviesInTheaterURL(region: region)) { (responceData) in
            if let movieList = try? JSONDecoder().decode(MovieList.self, from: responceData){
                complition(movieList)
            }
        }
    }
    
    func callRequestForMoviesDetail(movieID:Int, complition:@escaping(_ responceModal:MovieDetail) -> (Void)) {
        NetworkHandler.sharedInstance.getResponce(requestURL: movieDetailURL(movieID: movieID)) { (responceData) in
            if let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: responceData){
                complition(movieDetail)
            }
        }
    }
    func callRequestForMoviesVideos(movieID:Int, complition:@escaping(_ responceModal:MovieVideos) -> (Void)) {
        NetworkHandler.sharedInstance.getResponce(requestURL: movieVideosURL(movieID: movieID)) { (responceData) in
            if let movieVideos = try? JSONDecoder().decode(MovieVideos.self, from: responceData){
                complition(movieVideos)
            }
        }
    }
    func callRequestForMoviesCredits(movieID:Int, complition:@escaping(_ responceModal:MovieCredits) -> (Void)) {
        NetworkHandler.sharedInstance.getResponce(requestURL: movieCreditsURL(movieID: movieID)) { (responceData) in
            if let movieCredits = try? JSONDecoder().decode(MovieCredits.self, from: responceData){
                complition(movieCredits)
            }
        }
    }
}
