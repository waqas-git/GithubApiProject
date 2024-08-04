//
//  UserInfoVC.swift
//  JulyProject
//
//  Created by waqas ahmed on 30/07/2024.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject{
   func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
    
    var username: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLable   = GFBodyLabel(textAllignment: .center)
    var itemviews : [UIView] = []
    weak var userInfoDelegate : UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        layoutUI()
        getUser(userName: username)
    }
        func getUser(userName: String){
            NetworkManager.shared.getUsers(for: userName) { [weak self] result in
                guard let self = self else {return}
                
                switch result{
                case .success(let user):
                    DispatchQueue.main.async { self.configureUI(user: user) }
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Alert", message: error.rawValue, btnTitle: "OK")
                    break
                }
            }
        }
    
    private func configureUI(user: User){
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLable.text = "Github since \(user.createdAt.convertToMonthYearFormate())"
    }
        
        func configureNavigationBar(){
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
            navigationItem.rightBarButtonItem = doneButton
        }
        
        @objc func dismissVC(){
            dismiss(animated: true)
        }
    
    func layoutUI(){
        let padding: CGFloat = 20
        let itemHeight : CGFloat = 140
        itemviews = [headerView, itemViewOne, itemViewTwo, dateLable]
        
        for itemView in itemviews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
            
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLable.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLable.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension UserInfoVC : GFRepoItemVCDelegate, GFFollowerItemVCDelegate{
    func didTapGithubProfile(for user: User) {
        
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Alert", message: "This user have invalid html page", btnTitle: "Ok")
            return
        }
        presentSafariVC(url: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "Alert", message: "This user does not have any follower", btnTitle: "Ok")
            return
        }
        userInfoDelegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
