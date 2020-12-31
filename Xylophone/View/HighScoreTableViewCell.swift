//
//  HighScoreTableViewCell.swift
//  Xylophone
//
//  Created by Andrew on 31/12/20.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {

    @IBOutlet var surroundingBlockView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
