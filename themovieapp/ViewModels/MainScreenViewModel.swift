//
//  MainScreenViewModel.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import Foundation
import UIKit
import CRRefresh
import PagingTableView
import PopupDialog

class MainScreenViewModel: NSObject {
    
    var viewController: BaseViewController!
    
    //IBOutlets for movies
    @IBOutlet weak var moviesListTableView: PagingTableView!
    
    //All materials for list view
    var moviesListResult = [Results]()
    var listSearchResponse: MoviesResponse?
    
    //All materials for slide view
    var nowPlayingListResult = [Results]()
    var moviesToSlideResult = [Results]()
    var slideSearchResponse: MoviesResponse?
    
    //Slider materials
    var moviesNameArray = [String]()
    var moviesOverviewArray = [String]()
    var moviesImageArray = [String]()
    
    //Pagination
    var numberOfPage: Int = 0
    
    
    func setLayouts(viewController: BaseViewController) {
        self.viewController = viewController
        setTableView()
    }
    
    func setTableView() {
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        moviesListTableView.pagingDelegate = self
        moviesListTableView.register(UINib(nibName: "MoviesListHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "moviesListHeader")
        moviesListTableView.register(UINib(nibName: "MoviesListTableViewCell", bundle: nil), forCellReuseIdentifier: "moviesCell")
        moviesListTableView.backgroundColor = .white
        
        //Pull and Refresh
        moviesListTableView.cr.addHeadRefresh(animator: NormalHeaderAnimator()) { [self] in
            getListValueFromApi(page: numberOfPage)
            viewController.requestStatus = .completed
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [self] in
                moviesListTableView.cr.endHeaderRefresh()
            })
        }
        moviesListTableView.cr.beginHeaderRefresh()
    }
    
    func getListValueFromApi(page: Int) {
        NetworkManager.sharedManager.getMovies(movies: "upcoming", page: page) { [self] response in
            listSearchResponse = response
            guard let result = response.results else { return }
            moviesListResult.append(contentsOf: result)
            moviesListTableView.reloadData()
            NetworkManager.sharedManager.getMovies(movies: "now_playing", page: 1) { [self] response in
                slideSearchResponse = response
                guard let result = response.results else { return }
                moviesToSlideResult = result
            } errorHandler: { [self] error in
                viewController.showErrorDialog()
            }
        } errorHandler: { [self] error in
            viewController.showErrorDialog()
        }
    }
    
    @objc func showMovieDetail(_ sender: UIButton) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailScreenViewController") as? DetailScreenViewController
        controller?.movieId = moviesListResult[sender.tag].id
        viewController.navigationController?.pushViewController(controller!, animated: true)
    }
    
}

//MARK: - TableView Delegates -
extension MainScreenViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 450
        }
        
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailScreenViewController") as? DetailScreenViewController
        controller?.movieId = moviesListResult[indexPath.row].id
        viewController.navigationController?.pushViewController(controller!, animated: true)
    }
}

//MARK: - TableView DataSources -
extension MainScreenViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return moviesListResult.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = moviesListTableView.dequeueReusableCell(withIdentifier: "moviesListHeader", for: indexPath) as! MoviesListHeaderTableViewCell
            let moviesListHeaderViewModel = MoviesinSliderTableViewCellViewModel.init(results: moviesToSlideResult)
            cell.dataSource = moviesListHeaderViewModel
            cell.viewController = viewController as? MainScreenViewController
            cell.reloadData()
            return cell
        } else {
            let cell = moviesListTableView.dequeueReusableCell(withIdentifier: "moviesCell", for: indexPath) as! MoviesListTableViewCell
            let moviesListViewModel = MoviesTableViewCellViewModel.init(result: moviesListResult[indexPath.row])
            cell.dataSource = moviesListViewModel
            cell.reloadData()
            cell.showMovieDetailsButton.tag = indexPath.row
            cell.showMovieDetailsButton.addTarget(self, action: #selector(showMovieDetail), for: .touchUpInside)
            return cell
        }
    }
}

//MARK: - PagingTable Delegate -
extension MainScreenViewModel: PagingTableViewDelegate {
    func paginate(_ tableView: PagingTableView, to page: Int) {
        moviesListTableView.isLoading = true
        numberOfPage += 1
        getListValueFromApi(page: page)
        viewController.requestStatus = .completed
    }
}
