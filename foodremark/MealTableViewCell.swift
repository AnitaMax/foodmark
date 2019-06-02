//
//  MealTableViewCell.swift
//  foodremark
//
//  Created by Apple24 on 19/4/29.
//  Copyright © 2019年 zhy. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var FoodImage: UIImageView!
    @IBOutlet weak var rating: RatingController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
