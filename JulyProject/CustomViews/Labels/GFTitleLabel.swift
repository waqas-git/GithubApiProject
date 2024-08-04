//
//  GFTitleLabel.swift
//  JulyProject
//
//  Created by waqas ahmed on 20/07/2024.
//

import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuraiton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (textAllignment: NSTextAlignment, fontSize: CGFloat){
        self.init(frame: .zero)
        self.textAlignment = textAllignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    func configuraiton(){
        textColor                 = .label
        adjustsFontSizeToFitWidth = true
        lineBreakMode             = .byTruncatingTail
        minimumScaleFactor        = 0.9
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
