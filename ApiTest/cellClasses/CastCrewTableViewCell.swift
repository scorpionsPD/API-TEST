//
//  CastCrewTableViewCell.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 29/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class CastCrewTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var charecterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var item : SingleCredit? {
        didSet{
            guard let item = item else {
                return
            }
            NetworkHandler.sharedInstance.downloadImage(from: posterURL(posterPath: item.image), completion: { (imageContent) in
                DispatchQueue.main.async {
                    self.profileImage.image = imageContent
                }
            })
            self.realName.text = item.realName
            self.charecterName.text = item.charecterName
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
