//
//  HomeScreenDataSource.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 01/04/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

struct Movie {
    let image: String
    let origTitle: String
    let movieID: Int
}

class HomeScreenDataSource: NSObject {
    var movieArray = Array<Movie>()
    init(movieList:MovieList?) {
        if let results = movieList?.results {
            for result in results{
                if result.originalLanguage == languages.hindi.rawValue || result.originalLanguage == languages.english.rawValue{
                    if let imagePath = result.backdropPath,let origTitle:String = result.originalTitle {
                        let singleMovie = Movie(image: imagePath, origTitle: origTitle, movieID: result.id)
                        self.movieArray.append(singleMovie)
                    }
                }
            }
        }
    }
}

extension HomeScreenDataSource: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListTableViewCell.self)) as! MovieListTableViewCell
        cell.item = movieArray[indexPath.row]
        return cell
    }
}



