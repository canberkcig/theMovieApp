//
//  DetailScreenViewController.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import UIKit

class DetailScreenViewController: BaseViewController {

    @IBOutlet weak var detailViewModel: DetailScreenViewModel!
    var movieId: Int!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromApi()
    }
    
    func getDataFromApi() {
        prepareForRequest()
        self.getAllData()
        
    }
    
    func getAllData(){
        detailViewModel.setDetailLayouts(viewController: self, movieId: movieId)
    }
    
    private func prepareForRequest() {
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            DispatchQueue.main.async {
                self.requestStatus = .pending
            }
        }
      }
    
    override func viewWillLayoutSubviews(){
          super.viewWillLayoutSubviews()
        if UIScreen.main.bounds.height > 1365 {
            screenHeight = 1.1
        } else if UIScreen.main.bounds.height > 890 {
            screenHeight = 1.1
        }
        else if UIScreen.main.bounds.height > 800 {
            screenHeight = 1.2
        }
        else if UIScreen.main.bounds.height > 730 && UIScreen.main.bounds.height < 800 {
            screenHeight = 1.2
        } else {
            screenHeight = 1.4
        }
        detailViewModel.detailScrollView.translatesAutoresizingMaskIntoConstraints = false
        detailViewModel.detailScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        detailViewModel.detailScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailViewModel.detailScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * screenHeight)
      }
}
