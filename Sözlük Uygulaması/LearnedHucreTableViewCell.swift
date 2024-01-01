//
//  LearnedHucreTableViewCell.swift
//  Sözlük Uygulaması
//
//  Created by Fırat İlhan on 16.12.2023.
//

import UIKit

class LearnedHucreTableViewCell: UITableViewCell {

    @IBOutlet weak var ingilizceLabel: UILabel!
    @IBOutlet weak var turkceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
