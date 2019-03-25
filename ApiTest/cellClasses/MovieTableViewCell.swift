//
//  MovieTableViewCell.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 26/02/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    let imgUser = UIImageView()
    let labUerName = UILabel()
    let labMessage = UILabel()
    let labTime = UILabel()
    var message : String?
    var mainImage : UIImage?
    
    var messageView : UILabel = {
       var nameLbl = UILabel()
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.numberOfLines = 0
        nameLbl.backgroundColor = UIColor.transBlackColor()
        nameLbl.textAlignment = .center
        nameLbl.font = UIFont.titleFont()
        nameLbl.textColor = UIColor.white
        return nameLbl
    }()
    
    var mainImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .redraw
        return imageView
    }()
    
    override func layoutSubviews() {
        
        if let message = message {
            self.messageView.text = message
        }
        if let image = mainImage {
            self.mainImageView.image = image
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(mainImageView)
        self.addSubview(messageView)
        self.selectionStyle = .none
        
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: MAX_WIDTH).isActive = true
        
        mainImageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true

        messageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor, constant: MAX_WIDTH - 40).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        messageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        imgUser.backgroundColor = UIColor.blue
//
//
//        imgUser.translatesAutoresizingMaskIntoConstraints = false
//        labUerName.translatesAutoresizingMaskIntoConstraints = false
//        labMessage.translatesAutoresizingMaskIntoConstraints = false
//        labTime.translatesAutoresizingMaskIntoConstraints = false
//
//        contentView.addSubview(imgUser)
//        contentView.addSubview(labUerName)
//        contentView.addSubview(labMessage)
//        contentView.addSubview(labTime)
//
//        let viewsDict = [
//            "image" : imgUser,
//            "username" : labUerName,
//            "message" : labMessage,
//            "labTime" : labTime,
//            ]
//
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(10)]", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[labTime]-|", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-[image(10)]-|", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-[labTime]-|", options: [], metrics: nil, views: viewsDict))
//    }
    
}
