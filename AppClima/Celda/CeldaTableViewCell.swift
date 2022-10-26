//
//  CeldaTableViewCell.swift
//  AppClima
//
//  Created by José Antonio Vieyra García on 26/09/22.
//

import UIKit

class CeldaTableViewCell: UITableViewCell {

    @IBOutlet weak var timeTemp: UILabel!
    @IBOutlet weak var ts: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
