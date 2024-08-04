//
//  FavouriteListVC.swift
//  JulyProject
//
//  Created by waqas ahmed on 18/07/2024.
//

import UIKit

class FavouriteListVC: GFDataLoadingVC {

    let tableview            = UITableView()
    var favorite: [Follower] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewcontroller()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewcontroller(){
        view.backgroundColor = .systemBackground
        title                = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableview)
        tableview.frame       = view.bounds
        tableview.delegate    = self
        tableview.dataSource  = self
        tableview.rowHeight   = 80
        
        tableview.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.resuseID)
    }
    
    func getFavorites(){
        PersistanceManager.receiveFavourites { Result in
            
            switch Result{
            case .success(let favorite):
                if favorite.isEmpty{
                    self.showEmptyStateView(with: "No Favorites?", in: self.view)
                }else{
                    self.favorite = favorite
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                        self.view.bringSubviewToFront(self.tableview)
                    }
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, btnTitle: "Ok")
            }
        }
    }
}

extension FavouriteListVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.resuseID) as! FavoriteCell
        let favorite = favorite[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite            = favorite[indexPath.row]
        let followerListVC      = FollowerListVC(username: favorite.login)
        navigationController?.pushViewController(followerListVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        PersistanceManager.updateWith(favorite: self.favorite[indexPath.row], actionType: .remove) { [weak self] Error in
            guard let self = self else {return}
            guard let Error = Error else{
                self.favorite.remove(at: indexPath.row)
                self.tableview.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: Error.rawValue, btnTitle: "Ok")
            
        }
    }
    
}
