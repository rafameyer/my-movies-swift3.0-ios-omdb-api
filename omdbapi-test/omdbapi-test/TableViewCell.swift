//
//  TableViewCell.swift
//  omdbapi-test
//
//  Created by Joel Sene on 06/04/17.
//  Copyright © 2017 Rafael Meyer. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameMovieText: UILabel!
    @IBOutlet weak var typeMovieText: UILabel!
    @IBOutlet weak var yearMovieText: UILabel!
    @IBOutlet weak var imageMovieText: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
