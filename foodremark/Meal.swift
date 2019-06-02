//
//  Meal.swift
//  foodremark
//
//  Created by Apple24 on 19/4/29.
//  Copyright © 2019年 zhy. All rights reserved.
//

import UIKit
import os.log
class Meal:NSCoder,NSCoding{
    //properties
    var name:String
    var photo:UIImage?
    var rating:Int
    
    //Paths
    static let DocDir = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiverURL = DocDir.appendingPathComponent("meals")
    //init
    init? (name:String,photo:UIImage?,rating:Int){
        if name.isEmpty||rating<0||rating>5 {
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: ProvertyKey.name)
        aCoder.encode(photo, forKey: ProvertyKey.photo)
        aCoder.encode(rating, forKey: ProvertyKey.rating)
        
    }
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey:ProvertyKey.name) as? String
            else{
                os_log("Unale to decode the name from a Meal Object",log:OSLog.default,type:.debug)
                return nil
        }
        let photo = aDecoder.decodeObject(forKey:ProvertyKey.photo) as? UIImage
        let rate = aDecoder.decodeInteger(forKey:ProvertyKey.rating)

        self.init(name: name, photo: photo, rating: rate)
        
    }
    
}
