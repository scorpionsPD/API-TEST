//
//  MovieListTableViewCell.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 01/04/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var originalTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var item: Movie?{
        didSet{
            NetworkHandler.sharedInstance.downloadImage(from: posterURL(posterPath: (item?.image)!), completion: { (imageContent) in
                DispatchQueue.main.async {
                    self.mainImage.image = imageContent
                    self.originalTitle.text = self.item?.origTitle
                }
            })
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
