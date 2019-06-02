//
//  RatingController.swift
//  foodremark
//
//  Created by Apple24 on 19/4/29.
//  Copyright © 2019年 zhy. All rights reserved.
//

import UIKit

@IBDesignable
class RatingController: UIStackView {
    // 类的属性
    var ratingButtons = [UIButton]()
    
    var rating:Int = 0 {
        //属性检测器
        didSet{
            setUpButton()
        }
    }
    
    @IBInspectable
    var starCount :Int = 5{
        //属性检测器
        didSet{
            setUpButton()
        }
    }
    
    @IBInspectable
    var starSize:CGSize = CGSize(width: 44, height: 44){
        didSet{
            setUpButton()
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpButton()
    }
       func  setUpButton()  {
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //选择应用路径
        let bundle = Bundle(for: type(of:self))
        let filledStar = UIImage(named: "filled star",in :bundle,compatibleWith:self.traitCollection)
        let emptyStar = UIImage(named: "empty star",in :bundle,compatibleWith:self.traitCollection)
        let highlightStar = UIImage(named: "highlighted star",in :bundle,compatibleWith:self.traitCollection)
        
        for _ in 0..<starCount{
            let button = UIButton()
            // 设置按钮图片
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightStar, for: .highlighted)
            button.setImage(highlightStar, for: [.highlighted, .selected])
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            //绑定方法or事件
            button.addTarget(self, action: #selector(RatingController.tapRatingButton(button:)), for: .touchUpInside)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    func tapRatingButton(button:UIButton){
        let index:Int = ratingButtons.index(of: button)!
        let selectedRating = index+1
        if selectedRating == rating {
            rating=0
        }else{
            rating=selectedRating
        }
        updateButtonSelectionStates()
    }
    private func updateButtonSelectionStates(){
        for(index,button) in ratingButtons.enumerated(){
            button.isSelected = index<rating
        }
    }
}
