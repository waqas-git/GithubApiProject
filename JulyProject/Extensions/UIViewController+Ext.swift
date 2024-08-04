//
//  UIViewController+Ext.swift
//  JulyProject
//
//  Created by waqas ahmed on 20/07/2024.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, btnTitle: String){
        DispatchQueue.main.async {
            let alertVc = AlertVC(title: title, message: message, buttonTitle: btnTitle)
            alertVc.modalPresentationStyle = .overFullScreen
            alertVc.modalTransitionStyle   = .crossDissolve
            self.present(alertVc, animated: true)
        }
    }
    
    func presentSafariVC(url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
  
    
}
