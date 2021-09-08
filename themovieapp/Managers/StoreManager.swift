//
//  StoreManager.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import Foundation


class StoreManager {
    
    static let shared = StoreManager()
    
    private static func storeMovies(data : [Results]) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: data as NSArray) as NSData
    }
    
    
    func loadMoviesModel() -> [Results]? {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: "movies") as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Results]
        }
        
        return []
    }
    
    func saveMoviesModel(data : [Results]?) {
       
       let archivedObject = StoreManager.storeMovies(data: data!)
       UserDefaults.standard.set(archivedObject, forKey: "movies")
       UserDefaults.standard.synchronize()
   }
    
    func getMovieModels() -> [Results] {
        var movieModels: [Results] = [Results]()
        if StoreManager.shared.loadMoviesModel() == nil {
            StoreManager.shared.saveMoviesModel(data: movieModels)
        }
        else {
            movieModels = StoreManager.shared.loadMoviesModel() ?? []
        }
        return movieModels
    }
}
