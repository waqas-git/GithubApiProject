//
//  PersistanceManager.swift
//  JulyProject
//
//  Created by waqas ahmed on 02/08/2024.
//

import Foundation

enum PersistanceActionType{
    case add, remove
}

enum PersistanceManager{
    static private let defaults = UserDefaults.standard
    
    enum keys{
        static let favourite = "favourite"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completed: @escaping(GFError?)-> Void ){
        receiveFavourites { Result in
            switch Result{
            case .success(var favorites):
                switch actionType{
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavourite)
                        return
                    }
                    favorites.append(favorite)
                
                case .remove:
                    favorites.removeAll{$0.login == favorite.login}
                    
                }
                
                completed(saveFavourites(favourites: favorites))
                
            case .failure(let error):
                completed(error)
                return
            }
        }
        
    }
    
    static func receiveFavourites(completed: @escaping (Result<[Follower], GFError>)-> Void) {
        guard let favouriteDate = defaults.object(forKey: keys.favourite) as? Data else {
            completed(.success([]))
            return
        }
        do{
            let docoder = JSONDecoder()
            let favourite = try docoder.decode([Follower].self, from: favouriteDate)
            completed(.success(favourite))
        }catch{
            completed(.failure(.unableToFavourite))
        }
    }
    
    static func saveFavourites(favourites: [Follower]) -> GFError? {
        do{
            let encoder = JSONEncoder()
            let favouriteDate = try encoder.encode(favourites)
            defaults.set(favouriteDate, forKey: keys.favourite)
            return nil
        }catch{
            return .unableToFavourite
        }
    }
    
}
