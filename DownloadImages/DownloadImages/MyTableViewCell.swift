//
//  MyTableViewCell.swift
//  DownloadImages
//
//  Created by Mr.Ocumare on 08/06/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var TherdLabel: UILabel!
    @IBOutlet weak var SecondLabel: UILabel!
    @IBOutlet weak var FirstLabel: UILabel!
    @IBOutlet weak var MyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
