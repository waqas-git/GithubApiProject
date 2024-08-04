//
//  GFBodyLabel.swift
//  JulyProject
//
//  Created by waqas ahmed on 20/07/2024.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configuraiton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (textAllignment: NSTextAlignment){
        self.init(frame: .zero)
        self.textAlignment = textAllignment
    }
    
    func configuraiton(){
        textColor                         = .secondaryLabel
        font                              = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth         = true
        lineBreakMode                     = .byWordWrapping
        minimumScaleFactor                = 0.75
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    

}
