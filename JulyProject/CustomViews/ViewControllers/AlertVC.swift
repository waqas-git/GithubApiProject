//
//  AlertVC.swift
//  JulyProject
//
//  Created by waqas ahmed on 20/07/2024.
//

import UIKit

class AlertVC: UIViewController {
    
    let containerView = UIView()
    let alertTitle =  GFTitleLabel(textAllignment: .center, fontSize: 20)
    let alertBody =  GFBodyLabel(textAllignment: .center)
    let alertBtn = GFButton(backgroundColor: UIColor.systemPink, title: "Ok")
    
    var textTitle : String?
    var message : String?
    var buttonTitle : String?
    
    let padding : CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configuareContainerView()
        configuareTitle()
        configuareAlertBTn()
        configuareMessage()
    }
    
    init(title: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.textTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuareContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor    = .systemBackground
        containerView.layer.borderColor  = UIColor.white.cgColor
        containerView.layer.borderWidth  = 2
        containerView.layer.cornerRadius = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func configuareTitle(){
        containerView.addSubview(alertTitle)
        alertTitle.text = textTitle ?? "Title not found"
        
        NSLayoutConstraint.activate([
            alertTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertTitle.heightAnchor.constraint(equalToConstant: 30),
            alertTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding)
        ])
    }
    
    func configuareMessage(){
        containerView.addSubview(alertBody)
        alertBody.text = message ?? "Message not found"
        alertBody.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            alertBody.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: 8),
            alertBody.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertBody.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertBody.bottomAnchor.constraint(equalTo: alertBtn.topAnchor, constant: 12)
        ])
    }
    
    func configuareAlertBTn(){
        containerView.addSubview(alertBtn)
        alertBtn.setTitle(buttonTitle ?? "Ok", for: .normal)
        alertBtn.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            alertBtn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            alertBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func dismissAlert(){
        dismiss(animated: true)
    }
}
