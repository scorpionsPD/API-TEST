//
//  MovieDetailsViewController.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 05/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit
import UICircularProgressRing

@available(iOS 12.0, *)
class MovieDetailsViewController: UITableViewController {

    var selectedMovie: Movie?
    
    var detailDataSource: DetailDataSource?
    var completeMovieDetailModal: CompleteMovieDetailModal?
    
    var background: UIImageView = {
        let bg = UIImageView()
        bg.backgroundColor = UIColor.gray
        bg.frame = CGRect(x: 0, y: -60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height+60)
        bg.addBlurEffect()
        return bg
    }()
    
    
    
    var ratingScore: UIButton = {
        let rating = UIButton()
        rating.tintColor = UIColor.white
        rating.setImage(UIImage(named: "ratingIcon"), for: .normal)
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    
    
    var rating: UIBarButtonItem = {
        let rating = UIBarButtonItem()
        rating.tintColor = UIColor.white
        rating.image = UIImage(named: "ratingIcon")
        return rating
    }()
    
    var detailsTableView:UITableView = {
        
        let table = UITableView()
        table.frame = CGRect(x: 0, y:0, width: MAX_WIDTH, height: MAX_HEIGHT-60)
        
        table.separatorStyle = .none
        table.autoresizesSubviews = false
       
        let nibHeader = UINib.init(nibName: String(describing: MovieHeaderCell.self), bundle: nil)
        table.register(nibHeader, forCellReuseIdentifier: String(describing: MovieHeaderCell.self))
        
        let nibVideos = UINib.init(nibName: String(describing: MovieVideosTableViewCell.self), bundle: nil)
        table.register(nibVideos, forCellReuseIdentifier: String(describing: MovieVideosTableViewCell.self))
        
        let nibCasting = UINib.init(nibName: String(describing: CastCrewTableViewCell.self), bundle: nil)
        table.register(nibCasting, forCellReuseIdentifier: String(describing: CastCrewTableViewCell.self))
        
        return table
    }()
    
    var options: UISegmentedControl = {
        let items = ["Casts","Posters"]
        let segmentedControl = UISegmentedControl(items : items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = .black
        segmentedControl.tintColor = .darkGray
        return segmentedControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkHandler.sharedInstance.downloadImage(from: posterURL(posterPath: selectedMovie!.image)) { (posterImage) in
            DispatchQueue.main.async {
                self.updateUI(imageBG: posterImage)
            }
        }
        
        RequestCreator.shared.callRequestForMoviesDetail(movieID: (selectedMovie?.movieID)!) { (details) -> (Void) in
            DispatchQueue.main.async {
                self.ratingScore.setTitle(String(details.voteAverage), for: .normal)
                self.detailsTableView.backgroundColor = UIColor.clear
                self.detailsTableView.separatorStyle = .none
                RequestCreator.shared.callRequestForMoviesVideos(movieID: (self.selectedMovie?.movieID)!, complition: { (videoDetail) -> (Void) in
                    RequestCreator.shared.callRequestForMoviesCredits(movieID: (self.selectedMovie?.movieID)!) { (credits) -> (Void) in
                        DispatchQueue.main.async {
                            self.completeMovieDetailModal = CompleteMovieDetailModal(movieDetail: details, movieVideos: videoDetail, credits: credits)
                            self.detailDataSource = DetailDataSource(data: self.completeMovieDetailModal)
                            self.detailsTableView.dataSource = self.detailDataSource
                            reloadScrolableView(table: self.detailsTableView)
                        }
                    }
                })
            }
        }
    }
    func updateUI(imageBG:UIImage){
        self.background.image = imageBG
        self.view.addSubview(self.background)
        self.view.addSubview(self.detailsTableView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.ratingScore)
    }
}
