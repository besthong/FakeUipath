//
//  CustomCellTableViewCell.swift
//  FakeUipath
//
//  Created by 훈쓰 on 2022/02/12.
//

import UIKit

class RobotCell: UITableViewCell {

    @IBOutlet weak var RobotName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
