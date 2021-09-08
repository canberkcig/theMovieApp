//
//  MoviesDetailResponse.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import Foundation


class MoviesDetailResponse: NSObject, Decodable, NSCoding {
    
    var poster_path: String?
    var original_title: String?
    var overview: String?
    var vote_average: Double?
    var homepage: String?
    var release_date: String?
    var imdb_id: String?
    
    required init(original_title: String, release_date: String, overview: String, poster_path: String, vote_average: Double, imdb_id: String) {
        self.original_title = original_title
        self.release_date = release_date
        self.overview = overview
        self.poster_path = poster_path
        self.vote_average = vote_average
        self.imdb_id = imdb_id
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        original_title = (aDecoder.decodeObject(forKey: "original_title")) as? String
        release_date = (aDecoder.decodeObject(forKey: "release_date")) as? String
        overview = (aDecoder.decodeObject(forKey: "overview")) as? String
        poster_path = (aDecoder.decodeObject(forKey: "poster_path")) as? String
        imdb_id = (aDecoder.decodeObject(forKey: "imdb_id")) as? String
        vote_average = (aDecoder.decodeDouble(forKey: "vote_average"))
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(original_title, forKey: "original_title")
        aCoder.encode(release_date, forKey: "release_date")
        aCoder.encode(overview, forKey: "overview")
        aCoder.encode(poster_path, forKey: "poster_path")
        aCoder.encode(vote_average, forKey: "vote_average")
        aCoder.encode(imdb_id, forKey: "imdb_id")
    }
    
}
