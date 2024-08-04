//
//  GFSecondaryTitleLabel.swift
//  JulyProject
//
//  Created by waqas ahmed on 30/07/2024.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuraiton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (fontSize: CGFloat){
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    func configuraiton(){
        textColor                 = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        lineBreakMode             = .byTruncatingTail
        minimumScaleFactor        = 0.9
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
