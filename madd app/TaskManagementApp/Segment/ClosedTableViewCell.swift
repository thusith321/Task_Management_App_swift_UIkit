//
//  ClosedTableViewCell.swift
//  TaskManagementApp
//
//  Created by Sajani Jayasinghe on 2023-04-22.
//

import UIKit

class ClosedTableViewCell: UITableViewCell {

    @IBOutlet var closedImage: UIImageView!
    @IBOutlet var closedName: UILabel!
    @IBOutlet var closedType: UILabel!
    @IBOutlet var closedDays: UILabel!
    @IBOutlet var donebtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        donebtn.layer.cornerRadius = 13

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
