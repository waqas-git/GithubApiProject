//
//  FollowerListVC.swift
//  JulyProject
//
//  Created by waqas ahmed on 20/07/2024.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
    enum Section{
        case main
    }

    var username: String!
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    var follower: [Follower] = []
    var filterFollowers: [Follower] = []
    var page: Int = 1
    var hasMoreFollower = true
    var isSearching     = false
    var isloadingMoreFollowers = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuareViewcontroller()
        configuareCollectionView()
        getFollowers(username: self.username, page: page)
        configuareDataSource()
        configurSearchController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
     init(username: String) {
         super.init(nibName: nil, bundle: nil)
         self.username = username
         title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuareViewcontroller() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped(){
        print("add button tapped")
        showLoading()
        NetworkManager.shared.getUsers(for: username) { [weak self]Result in
            guard let self = self else{return}
            dismissLoadingView()
            
            switch Result{
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else{return}
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success!", message: "User has been added to Favorites.", btnTitle: "Ok")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, btnTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, btnTitle: "Ok")
            }
        }
    }
    
    func configuareCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.threeColumnFlowLayout(in: view))
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate        = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.resuseID)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    }
    
    func configurSearchController(){
        let searchController                   = UISearchController()
        searchController.searchResultsUpdater  = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController        = searchController
    }
    
    override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            collectionView.collectionViewLayout.invalidateLayout()
        }

    
    func getFollowers(username: String, page: Int){
        self.showLoading()
        isloadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result{
            case .success(let followers):
                if (followers!.count) < 100 {self.hasMoreFollower = false}
                self.follower.append(contentsOf: followers!)
                if self.follower.isEmpty{
                    let message = "This user does not have any follower. Please follow them 😀."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message , in: self.view)
                        return
                    }
                }
                
                self.updateDate(for: follower)
                print(followers!)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Title", message: error.rawValue, btnTitle: "Ok")
            }
        }
        isloadingMoreFollowers = false
    }
    
    func configuareDataSource(){
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follwers)-> UICollectionViewCell?  in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.resuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follwers)
            
            return cell
        })
    }
    
    func updateDate(for followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.datasource.apply(snapshot, animatingDifferences: true) }
    }

}


extension FollowerListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeigth = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeigth - height {
            guard hasMoreFollower, !isloadingMoreFollowers else {return}
            page += 1
            getFollowers(username: self.username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filterFollowers : follower
        
        let follower    = activeArray[indexPath.item]
        
        let destVC              = UserInfoVC()
        destVC.username         = follower.login
        destVC.userInfoDelegate = self
        let navController       = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
    }
}

extension FollowerListVC : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else {
            filterFollowers.removeAll()
            isSearching = false
            updateDate(for: follower)
            return
        }
        isSearching = true
        filterFollowers = follower.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateDate(for: filterFollowers)
    }
}

extension FollowerListVC : UserInfoVCDelegate{
    func didRequestFollowers(for username: String) {
        self.username = username
        title           = username
        page            = 1
        follower.removeAll()
        filterFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
    
}
