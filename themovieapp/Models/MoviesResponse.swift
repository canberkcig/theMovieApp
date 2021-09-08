//
//  MoviesResponse.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import Foundation

class MoviesResponse: Decodable {
    
    var total_results: Int?
    var results: [Results]?
    var total_pages: Int?
}

class Results: NSObject, Decodable, NSCoding {
    
    var id: Int?
    var original_title: String?
    var release_date: String?
    var overview: String?
    var poster_path: String?
    var vote_average: Double?
    
    required init(id: Int, original_title: String, release_date: String, overview: String, poster_path: String, vote_average: Double) {
        self.id = id
        self.original_title = original_title
        self.release_date = release_date
        self.overview = overview
        self.poster_path = poster_path
        self.vote_average = vote_average
    }
    
    required init(coder aDecoder: NSCoder) {
        
        id = (aDecoder.decodeInteger(forKey: "id"))
        original_title = (aDecoder.decodeObject(forKey: "original_title")) as? String
        release_date = (aDecoder.decodeObject(forKey: "release_date")) as? String
        overview = (aDecoder.decodeObject(forKey: "overview")) as? String
        poster_path = (aDecoder.decodeObject(forKey: "poster_path")) as? String
        vote_average = (aDecoder.decodeDouble(forKey: "vote_average"))
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(original_title, forKey: "original_title")
        aCoder.encode(release_date, forKey: "release_date")
        aCoder.encode(overview, forKey: "overview")
        aCoder.encode(poster_path, forKey: "poster_path")
        aCoder.encode(vote_average, forKey: "vote_average")
    }
    
}
