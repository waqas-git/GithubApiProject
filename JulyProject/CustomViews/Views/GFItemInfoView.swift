//
//  GFItemInfoView.swift
//  JulyProject
//
//  Created by waqas ahmed on 31/07/2024.
//

import UIKit

class GFItemInfoView: UIView {
    
    enum ItemInfoType {
        case repos, gitst, following, followers
    }

    let sysmbolImageView = UIImageView()
    let titleLable = GFTitleLabel(textAllignment: .left, fontSize: 14)
    let countLable = GFTitleLabel(textAllignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubviews(sysmbolImageView, titleLable, countLable)
        
        sysmbolImageView.translatesAutoresizingMaskIntoConstraints = false
        sysmbolImageView.contentMode = .scaleAspectFill
        sysmbolImageView.tintColor   = .label
        
        NSLayoutConstraint.activate([
            sysmbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            sysmbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sysmbolImageView.heightAnchor.constraint(equalToConstant: 20),
            sysmbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLable.centerYAnchor.constraint(equalTo: sysmbolImageView.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalTo: sysmbolImageView.trailingAnchor, constant: 5),
            titleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: 18),
            
            countLable.topAnchor.constraint(equalTo: sysmbolImageView.bottomAnchor, constant: 10),
            countLable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLable.heightAnchor.constraint(equalToConstant: 18)
        ])
        
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int){
        switch itemInfoType{
        case .repos:
            sysmbolImageView.image = SFSymbol.respos
            titleLable.text        = "Public Repos"
            countLable.text        = String(count)
            
        case .gitst:
            sysmbolImageView.image  = SFSymbol.gists
            titleLable.text         = "Public Gists"
            countLable.text        = String(count)
            
        case .following:
            sysmbolImageView.image = SFSymbol.following
            titleLable.text        = "Following"
            countLable.text        = String(count)
            
        case .followers:
            sysmbolImageView.image = SFSymbol.follers
            titleLable.text        = "Follwers"
            countLable.text        = String(count)
        }
    }
}
