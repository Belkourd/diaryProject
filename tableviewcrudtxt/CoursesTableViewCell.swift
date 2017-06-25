//
//  CoursesTableViewCell.swift
//  tableviewcrudtxt
//
//  Created by Kinki Lai on 2017/3/17.
//  Copyright © 2017年 Kinki Lai. All rights reserved.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var weblink: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var coursedate: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func webLinkAction(_ sender: UIButton) {
        
        UIApplication.shared.open(URL(string: weblink.text!)!)
        
    }

}
