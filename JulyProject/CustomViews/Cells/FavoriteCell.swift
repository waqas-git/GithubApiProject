//
//  FavoriteCell.swift
//  JulyProject
//
//  Created by waqas ahmed on 03/08/2024.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let resuseID = "FavoriteCell"
    
    let avatarImageview = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAllignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower){
        usernameLabel.text = favorite.login
        avatarImageview.downloadImage(from: favorite.avatarUrl)
    }
    
    private func configuare(){
        addSubviews(avatarImageview, usernameLabel)

        accessoryType = .disclosureIndicator
        
        let padding : CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageview.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageview.heightAnchor.constraint(equalToConstant: 60),
            avatarImageview.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageview.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
