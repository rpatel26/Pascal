//
//  CardNumber2TableViewCell.swift
//  Pascal
//
//  Created by Ravi Patel on 6/2/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class CardNumber2TableViewCell: UITableViewCell {

    @IBOutlet weak var card_number_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
