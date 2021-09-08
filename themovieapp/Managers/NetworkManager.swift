//
//  NetworkManager.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import Foundation
import UIKit
import Alamofire

class NetworkManager {
    
    static let sharedManager = NetworkManager()
    private var sessionManager = SessionManager()
    private init() { }
    
    fileprivate let encoding = JSONEncoding.default
    
    func getMovies(movies: String, page: Int, success:@escaping ((_ status: MoviesResponse)-> Void), errorHandler:@escaping ((_ status: Bool)-> Void)){
        let endpoint = "http://api.themoviedb.org/3/movie/\(movies)?api_key=77c0d339a9edf3afd0cf9d9ec81253c5&page=\(page)"
        sessionManager.request(endpoint, method: .get,encoding: encoding).responseData { (response) in
            let result = response.result
            switch result {
            case .success(let data):
                do {
                    let responseArray = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    success(responseArray)
                } catch  {
                    errorHandler(true)
                }
            case .failure(_ ):
                errorHandler(true)
            }
        }
    }
    
    func getMoviesDetail(moviesId: Int, success:@escaping ((_ status: MoviesDetailResponse)-> Void), errorHandler:@escaping ((_ status: Bool)-> Void)){
        let endpoint = "http://api.themoviedb.org/3/movie/\(moviesId)?api_key=77c0d339a9edf3afd0cf9d9ec81253c5"
        sessionManager.request(endpoint, method: .get,encoding: encoding).responseData { (response) in
            let result = response.result
            switch result {
            case .success(let data):
                do {
                    let responseArray = try JSONDecoder().decode(MoviesDetailResponse.self, from: data)
                    success(responseArray)
                } catch  {
                    errorHandler(true)
                }
            case .failure(_ ):
                errorHandler(true)
            }
        }
    }
    
}

