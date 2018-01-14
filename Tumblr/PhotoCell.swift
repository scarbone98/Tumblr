//
//  PhotoCell.swift
//  Tumblr
//
//  Created by Samuel Carbone on 1/12/18.
//  Copyright © 2018 Samuel Carbone. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    @IBOutlet weak var picture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
