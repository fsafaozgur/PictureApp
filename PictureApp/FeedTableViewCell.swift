//
//  FeedTableViewCell.swift
//  PictureApp
//
//  Created by Safa on 30.08.2023.
//

import UIKit

class FeedTableViewCell: UITableViewCell {


    @IBOutlet weak var emailFeed: UILabel!
    @IBOutlet weak var commentFeed: UILabel!
    @IBOutlet weak var imageFeed: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
