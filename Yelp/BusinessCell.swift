//
//  BusinessCell.swift
//  Yelp
//
//  Created by Siyu Song on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
//import UIImageView+

class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var ratingsImageView: UIImageView!
    
    var business:Business!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width
        self.thumbImageView.layer.cornerRadius = 3
        self.thumbImageView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBusiness(business : Business) {
        self.business = business
        
        self.thumbImageView.setImageWithURL(NSURL(string : self.business.imageURL))
        self.nameLabel.text = self.business.name
        self.ratingsImageView.setImageWithURL(NSURL(string : self.business.ratingImageUrl))
        self.addressLabel.text = self.business.address
        self.categoryLabel.text = self.business.categories
        self.ratingLabel.text = "\(self.business.numReviews) Reviews"
        self.distanceLabel.text = String(format : "%.2f miles", Float(self.business.distance))

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width
    }
}
