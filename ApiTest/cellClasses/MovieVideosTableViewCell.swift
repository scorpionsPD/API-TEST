//
//  MovieVideosTableViewCell.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 29/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView


struct MovieVideo {
    let name: String
    let key: String
}

class MovieVideosTableViewCell: UITableViewCell {

    @IBOutlet weak var videoPreview: WKYTPlayerView!
    
    @IBOutlet weak var videoTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var item: MovieVideo? {
        didSet{
            guard let item = item else {
                return
            }
            self.videoPreview.load(withVideoId: item.key)
            self.videoTitle.text = item.name
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
