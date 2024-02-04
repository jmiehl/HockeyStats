//
//  hockeyPlayerTableViewCell.swift
//  HockeyStats
//
//  Created by Joe Miehl on 2/2/24.
//

import UIKit

class hockeyPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var statsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with hockeyPlayer: HockeyPlayer) {
        nameLabel.text = ("\(hockeyPlayer.firstName) \(hockeyPlayer.lastName)")
        statsLabel.text = ("Position: \(hockeyPlayer.position)")
                          
    }

}
