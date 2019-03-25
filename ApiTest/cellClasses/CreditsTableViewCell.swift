//
//  CreditsTableViewCell.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 20/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class CreditsTableViewCell: UITableViewCell {
    
    var r_name : String?
    var c_name: String?
    var profileImage : UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var charecterName : UILabel = {
        var nameLbl = UILabel()
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.numberOfLines = 0
        nameLbl.backgroundColor = UIColor.clear
        nameLbl.textAlignment = .left
        nameLbl.font = UIFont.systemFont(ofSize: 13)
        nameLbl.textColor = UIColor.white
        return nameLbl
    }()
    
    var realName : UILabel = {
        var nameLbl = UILabel()
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.numberOfLines = 0
        nameLbl.backgroundColor = UIColor.clear
        nameLbl.textAlignment = .left
        nameLbl.font = UIFont.systemFont(ofSize: 10)
        nameLbl.textColor = UIColor.white
        return nameLbl
    }()
    
    var imgOfCharecter : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .redraw
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(imgOfCharecter)
        self.addSubview(charecterName)
        self.addSubview(realName)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        imgOfCharecter.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imgOfCharecter.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imgOfCharecter.widthAnchor.constraint(equalToConstant: MAX_WIDTH/8).isActive = true
        imgOfCharecter.heightAnchor.constraint(equalToConstant: MAX_WIDTH/7).isActive = true
        imgOfCharecter.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        charecterName.leftAnchor.constraint(equalTo: self.imgOfCharecter.rightAnchor).isActive = true
        charecterName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        charecterName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        charecterName.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        realName.leftAnchor.constraint(equalTo: self.imgOfCharecter.rightAnchor).isActive = true
        realName.topAnchor.constraint(equalTo: self.charecterName.bottomAnchor).isActive = true
        realName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        realName.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

struct SingleCredit {
    let charecterName: String
    let realName: String
    let image: String
}

class CreditsDataSource: NSObject {
    
    var castCredits = Array<SingleCredit>()
    
    init(credits: MovieCredits?) {
        if let unwrapedCredit = credits?.cast {
            for cred in unwrapedCredit{
                let newCredit = SingleCredit(charecterName: cred.character, realName: cred.name, image: cred.profilePath ?? "")
                self.castCredits.append(newCredit)
            }
        }
    }
}

extension CreditsDataSource: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castCredits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CreditsTableViewCell.self)) as! CreditsTableViewCell
        let credit = castCredits[indexPath.row]
        NetworkHandler.sharedInstance.downloadImage(from: posterURL(posterPath: credit.image)) { (downlodedImage) in
            DispatchQueue.main.async{
                cell.imgOfCharecter.image = downlodedImage
                cell.realName.text = credit.realName
                cell.charecterName.text = credit.charecterName
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
}
