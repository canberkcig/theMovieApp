//
//  MoviesTableViewCellViewModel.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import Foundation
import UIKit

class MoviesTableViewCellViewModel: NSObject {
    
    var result: Results?
    
    init(result: Results) {
        self.result = result
    }
}

extension MoviesTableViewCellViewModel: MoviesListTableViewCellDataSource {
    func imageForCell(_ cell: MoviesListTableViewCell) -> String {
        return result?.poster_path ?? ""
    }
    
    func nameForCell(_ cell: MoviesListTableViewCell) -> String {
        return result?.original_title ?? ""
    }
    
    func overviewForCell(_ cell: MoviesListTableViewCell) -> String {
        return result?.overview ?? ""
    }
    
    func releaseDateForCell(_ cell: MoviesListTableViewCell) -> String {
        return result?.release_date ?? ""
    }
    
    
}
