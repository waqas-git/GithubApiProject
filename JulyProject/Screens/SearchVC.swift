//
//  SearchVC.swift
//  JulyProject
//
//  Created by waqas ahmed on 18/07/2024.
//

import UIKit

class SearchVC: GFDataLoadingVC {
    
    let logoImageview = UIImageView()
    let usernameTF = GFTextField()
    let callToActionBtn = GFButton(backgroundColor: UIColor.systemGreen, title: "Get Followers")
    var isUsernameEntered: Bool {return !usernameTF.text!.isEmpty}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageview, usernameTF, callToActionBtn)
        configureLogoImageview()
        configureUsernameTF()
        configureCallToActionBtn()
        createDismissGestureTapKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTF.text = ""
    }
    
    func configureLogoImageview(){
        
        logoImageview.translatesAutoresizingMaskIntoConstraints = false
        logoImageview.image  = Images.gh_Logo
        
        NSLayoutConstraint.activate([
            logoImageview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: DeviceTypes.isiPhone8Standard ? 50 : 100),
            logoImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageview.heightAnchor.constraint(equalToConstant: 200),
            logoImageview.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureUsernameTF(){
        usernameTF.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTF.topAnchor.constraint(equalTo: logoImageview.bottomAnchor, constant: 50),
            usernameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTF.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionBtn(){
        callToActionBtn.addTarget(self, action: #selector(pushFollowerVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func createDismissGestureTapKeyboard(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
   @objc func pushFollowerVC(){
       guard isUsernameEntered else{
           presentGFAlertOnMainThread(title: "Alert", message: "There is no user name provided by the user. Please enter the user name again.", btnTitle: "Done")
           return
       }
       view.endEditing(true)
       let followerListVC      = FollowerListVC(username: usernameTF.text!)
       navigationController?.pushViewController(followerListVC, animated: true)
    }

}

extension SearchVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerVC()
        return true
    }
}
