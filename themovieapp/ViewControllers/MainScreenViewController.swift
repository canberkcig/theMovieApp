//
//  MainScreenViewController.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import UIKit

class MainScreenViewController: BaseViewController {
    
    @IBOutlet weak var mainScreenViewModel: MainScreenViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromApi()
    }
    
    func getDataFromApi() {
        prepareForRequest()
        self.getAllData()
    }
    
    func getAllData(){
        mainScreenViewModel?.setLayouts(viewController: self)
    }
    
    private func prepareForRequest() {
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            DispatchQueue.main.async {
                self.requestStatus = .pending
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        //Navigation Bar background color
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}
