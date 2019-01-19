//
//  listcell.swift
//  ListAlertMain
//
//  Created by Abood Hamdan on 1/16/19.
//  Copyright © 2019 Abood Hamdan. All rights reserved.
//

import UIKit

class listcell: UITableViewCell {

    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var statusindicator: UIImageView!
    @IBOutlet weak var statuslbl: UILabel!
    @IBOutlet weak var mutebtn: UIButton!
    @IBOutlet weak var timerbtn: UIButton!
    @IBOutlet weak var phonebtn: UIButton!
    @IBOutlet weak var correctbtn: UIButton!
    @IBOutlet weak var subnetmask: UILabel!
    @IBOutlet weak var ipaddress: UILabel!
    @IBOutlet weak var brsanbcmo1: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
