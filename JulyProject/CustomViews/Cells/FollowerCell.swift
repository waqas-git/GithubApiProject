//
//  FollowerCell.swift
//  JulyProject
//
//  Created by waqas ahmed on 27/07/2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let resuseID = "FollowerCell"
    
    let avatarImageview = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAllignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower){
        usernameLabel.text = follower.login
        avatarImageview.downloadImage(from: follower.avatarUrl)
    }
    
    private func configuare(){
        addSubviews(avatarImageview, usernameLabel)
        
        let padding : CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageview.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageview.heightAnchor.constraint(equalTo: avatarImageview.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageview.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
}
