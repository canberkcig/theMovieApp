//
//  MoviesinSliderTableViewCellViewModel.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import Foundation

class MoviesinSliderTableViewCellViewModel: NSObject {
    
    var results: [Results]?
    
    init(results: [Results]) {
        self.results = results
    }
}

extension MoviesinSliderTableViewCellViewModel: NowPlayingMoviesTableViewDataSource {
    func moviesDataArray(_ cell: MoviesListHeaderTableViewCell) -> [Results] {
        if let moviesDataModel = results {
            return moviesDataModel
        } else {
            return [Results]()
        }
    }
}
