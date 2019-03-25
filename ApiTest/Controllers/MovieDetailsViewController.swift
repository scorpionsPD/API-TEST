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
class MovieDetailsViewController: BaseClass {

    var selectedMovie: Result?
    var movieDetail: MovieDetail?
    var movieID: Int?
    var videosDataSource: VideosDataSource?
    
    
    var bannerView: UIImageView = {
        let baner = UIImageView()
        baner.backgroundColor = UIColor.gray
        baner.frame = CGRect(x: 0, y: -60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height+60)
        baner.addBlurEffect()
        return baner
    }()
    
    var profileView: UIImageView = {
        let profile = UIImageView()
        profile.backgroundColor = UIColor.yellow
        profile.frame = CGRect(x: 5, y: 70, width: MAX_WIDTH / 3, height: MAX_WIDTH / 2)
        return profile
    }()
    
    var movieNamelable: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.white
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.numberOfLines = 0 
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    var genre: UILabel = {
       let gen = UILabel()
        gen.textColor = UIColor.white
        gen.font = UIFont.systemFont(ofSize: 14)
        gen.numberOfLines = 0
        gen.translatesAutoresizingMaskIntoConstraints = false
        return gen
    }()
    
    var releaseDate: UILabel = {
        let release = UILabel()
        release.textColor = UIColor.white
        release.font = UIFont.systemFont(ofSize: 10)
        release.numberOfLines = 0
        release.translatesAutoresizingMaskIntoConstraints = false
        return release
    }()
    
    var ratingScore: UIButton = {
        let rating = UIButton()
        rating.tintColor = UIColor.white
        rating.setImage(UIImage(named: "ratingIcon"), for: .normal)
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    var overview:UITextView =  {
        let txtView = UITextView()
        txtView.textColor = UIColor.white
        txtView.font = UIFont.systemFont(ofSize: 12)
        txtView.frame = CGRect(x: 0, y: MAX_WIDTH / 2 + 70, width: MAX_WIDTH, height: 0)
        txtView.backgroundColor = UIColor.clear
        return txtView
        
    }()
    
    var rating: UIBarButtonItem = {
        let rating = UIBarButtonItem()
        rating.tintColor = UIColor.white
        rating.image = UIImage(named: "ratingIcon")
        return rating
    }()
    
    var videosTableView:UITableView = {
        let table = UITableView()
        table.frame = CGRect(x: 0, y: MAX_WIDTH / 2 + 70, width: MAX_WIDTH, height: MAX_WIDTH)
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        table.separatorStyle = .none
        
        table.register(VideosTableViewCell.self, forCellReuseIdentifier: String(describing: VideosTableViewCell.self))
        table.register(CreditsTableViewCell.self, forCellReuseIdentifier: String(describing: CreditsTableViewCell.self))
        return table
    }()
    
    var options: UISegmentedControl = {
        let items = ["Casts","Posters"]
        let segmentedControl = UISegmentedControl(items : items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = .black
        segmentedControl.tintColor = .darkGray
        segmentedControl.addTarget(self, action: #selector(MovieDetailsViewController.indexChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    var ratingView: RatingView = {
        let progressRing = RatingView()
        return progressRing
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkHandler.sharedInstance.downloadImage(from: posterURL(posterPath: selectedMovie!.posterPath)) { (posterImage) in
            DispatchQueue.main.async {
                self.updateUI(imageBG: posterImage)
            }
        }
    }
    func updateUI(imageBG:UIImage){
        
        self.profileView.image = imageBG
        self.bannerView.image = imageBG
        self.view.addSubview(self.bannerView)
        self.view.addSubview(self.profileView)
        self.view.addSubview(self.movieNamelable)
        self.view.addSubview(self.genre)
        self.view.addSubview(self.releaseDate)
        self.view.addSubview(self.overview)
        self.view.addSubview(self.videosTableView)
        self.view.addSubview(self.options)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.ratingScore)
    }
    override func viewWillAppear(_ animated: Bool) {
        RequestCreator.shared.callRequestForMoviesDetail(movieID: (selectedMovie?.id)!) { (details) -> (Void) in
            DispatchQueue.main.async {
                self.movieNamelable.text = details.title + "(" + String(details.releaseDate.prefix(4)) + ")"
                self.genre.text = details.genreString()
                self.releaseDate.text =  details.releaseDate
                self.overview.text = details.overview
                self.ratingScore.setTitle(String(details.voteAverage), for: .normal)
                adjustUITextViewHeight(arg: self.overview)
                
                self.videosTableView.backgroundColor = UIColor.clear
                self.videosTableView.separatorStyle = .none
                self.setupConstrints()
                adjusTableViewConstraints(arg: self.videosTableView, relativeTo: self.overview)
                RequestCreator.shared.callRequestForMoviesVideos(movieID: (self.selectedMovie?.id)!, complition: { (videoDetail) -> (Void) in
                    self.videosDataSource = VideosDataSource(videos: videoDetail)
                    DispatchQueue.main.async {
                        self.videosTableView.dataSource = self.videosDataSource
                        reloadScrolableView(table: self.videosTableView)
                    }
                })
            }
            self.movieDetail = details
        }
        
        
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            if let childVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CastingViewController.self)) as? CastingViewController{
                childVC.background.image = self.bannerView.image
                childVC.selectedMovieID = self.selectedMovie?.id
                addChildViewToController(childVC, parent: self)
                
            }
        case 1:
            print("Android")
        default:
            break
        }
    }
    
    func setupConstrints() {
        
        movieNamelable.leftAnchor.constraint(equalTo: self.profileView.rightAnchor).isActive = true
        movieNamelable.topAnchor.constraint(equalTo: self.profileView.topAnchor).isActive = true
        movieNamelable.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        movieNamelable.heightAnchor.constraint(equalToConstant: UILabel.heightForLabel(text: self.movieNamelable.text!, font: self.movieNamelable.font, width: self.movieNamelable.frame.size.width))
        
        genre.leftAnchor.constraint(equalTo: self.profileView.rightAnchor).isActive = true
        genre.topAnchor.constraint(equalTo: self.movieNamelable.bottomAnchor).isActive = true
        genre.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        genre.heightAnchor.constraint(equalToConstant: 20)
        
        releaseDate.leftAnchor.constraint(equalTo: self.profileView.rightAnchor).isActive = true
        releaseDate.topAnchor.constraint(equalTo: self.genre.bottomAnchor).isActive = true
        releaseDate.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        releaseDate.heightAnchor.constraint(equalToConstant: 20)
        
        overview.leftAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        overview.topAnchor.constraint(equalTo: self.profileView.bottomAnchor).isActive = true
        overview.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        options.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        options.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        options.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        videosTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        videosTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        videosTableView.bottomAnchor.constraint(equalTo: self.overview.bottomAnchor).isActive = true
        
    }
}
