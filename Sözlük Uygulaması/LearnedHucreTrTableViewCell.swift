//
//  LearnedHucreTrTableViewCell.swift
//  Sözlük Uygulaması
//
//  Created by Fırat İlhan on 31.12.2023.
//

import UIKit

class LearnedHucreTrTableViewCell: UITableViewCell {

    @IBOutlet weak var turkceLabel: UILabel!
    
    @IBOutlet weak var ingilizceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
