//
//  movieTVC.swift
//  MovieBuzz
//
//  Created by GOQii-Subhojit on 06/11/20.
//  Copyright © 2020 SpcaeTown-Subhojit. All rights reserved.
//

import UIKit

class movieTVC: UITableViewCell {
    
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var nameLblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var releaseDtHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgBackView: UIView!
    
    
    static let reuseIdentifier = "movieTVC"
    static func nib() -> UINib {
        return UINib(nibName: "movieTVC", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgBackView.addShadowLayer(view: imgBackView)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
