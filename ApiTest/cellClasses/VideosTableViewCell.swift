//
//  VideosTableViewCell.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 22/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

struct MovieVideo {
    let name: String
    let key: String
}

class VideosTableViewCell: UITableViewCell {

    var videoTitle : UILabel = {
        var titleLbl = UILabel()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.numberOfLines = 0
        titleLbl.backgroundColor = UIColor.clear
        titleLbl.textAlignment = .left
        titleLbl.font = UIFont.systemFont(ofSize: 10)
        titleLbl.textColor = UIColor.white
        return titleLbl
    }()
    
    var VideoPlayer : WKYTPlayerView = {
        var player = WKYTPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        player.contentMode = .scaleToFill
        
        return player
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(VideoPlayer)
        self.addSubview(videoTitle)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
        VideoPlayer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        VideoPlayer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        VideoPlayer.widthAnchor.constraint(equalToConstant: MAX_WIDTH).isActive = true
        VideoPlayer.heightAnchor.constraint(equalToConstant: MAX_WIDTH/3).isActive = true
        VideoPlayer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        videoTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        videoTitle.widthAnchor.constraint(equalToConstant: MAX_WIDTH).isActive = true
        videoTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideosDataSource: NSObject {
    
    var movieVideosArray = Array<MovieVideo>()
    
    init(videos: MovieVideos?) {
        if let unwrapedCredit = videos?.results {
            for video in unwrapedCredit{
                let newVideo = MovieVideo(name: video.name, key: video.key)
                self.movieVideosArray.append(newVideo)
            }
        }
        self.movieVideosArray.reverse()
    }
}

extension VideosDataSource: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieVideosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == detailSection.header.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VideosTableViewCell.self)) as! VideosTableViewCell
            DispatchQueue.main.async{
                let video = self.movieVideosArray[indexPath.row]
                cell.videoTitle.text = video.name
                cell.VideoPlayer.load(withVideoId: video.key)
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CreditsTableViewCell.self)) as! CreditsTableViewCell
            cell.charecterName.text = self.movieVideosArray[indexPath.row].name
            return cell
        }
        
    }
}
