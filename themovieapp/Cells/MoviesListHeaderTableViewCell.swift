//
//  MoviesListHeaderTableViewCell.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import UIKit


protocol NowPlayingMoviesTableViewDataSource {
    func moviesDataArray(_ cell: MoviesListHeaderTableViewCell) -> [Results]
}

class MoviesListHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviesScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var dataSource: NowPlayingMoviesTableViewDataSource!
    var viewController: MainScreenViewController!
    
    var timer: Timer = Timer()
    var interval: Double = 1.0
    var currentPageNumber: CGFloat!
    var yOffset: CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        moviesScrollView.delegate = self
    }
    
    func reloadData() {
        let moviesDataModel = dataSource.moviesDataArray(self)
        
        for index in 0..<moviesDataModel.count{
            
            let movieNameLabel = UILabel()
            guard let original_title = moviesDataModel[index].original_title else { return }
            movieNameLabel.setLabelProperties(frame: CGRect(x: 20 + (CGFloat(index) * UIScreen.main.bounds.width), y: self.frame.height - 180, width: UIScreen.main.bounds.width - 40, height: 40),
                                              text: original_title,
                                              textColor: .white,
                                              font: "DMSans-Bold",
                                              fontSize: 19) { [self] in
                movieNameLabel.backgroundColor = .clear
                movieNameLabel.adjustsFontSizeToFitWidth = true
                moviesScrollView.insertSubview(movieNameLabel, at: 1)
            }
            
            
            let movieOverviewLabel = UILabel()
            guard let overview = moviesDataModel[index].overview else { return }
            movieOverviewLabel.setLabelProperties(frame: CGRect(x: 20 + (CGFloat(index) * UIScreen.main.bounds.width), y: self.frame.height - 140, width: UIScreen.main.bounds.width - 40, height: 80),
                                                  text: overview,
                                                  textColor: .white,
                                                  font: "DMSans-Medium",
                                                  fontSize: 15) { [self] in
                movieOverviewLabel.backgroundColor = .clear
                movieOverviewLabel.numberOfLines = 0
                moviesScrollView.insertSubview(movieOverviewLabel, at: 1)
            }
            
            let shadowImageView: UIImageView = UIImageView(frame: CGRect(x: CGFloat(index) * UIScreen.main.bounds.width, y: moviesScrollView.frame.height - 200, width: moviesScrollView.frame.width, height: 250))
            shadowImageView.image = UIImage(named: "detailShadow")
            moviesScrollView.insertSubview(shadowImageView, at: 0)
            
            let imageView = UIImageView()
            imageView.backgroundColor = .white
            imageView.frame = CGRect(x: CGFloat(index) * UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: self.frame.height)
            self.setNeedsLayout()
            self.layoutIfNeeded()
            imageView.contentMode = .scaleAspectFit
            moviesScrollView.insertSubview(imageView, at: 0)
            guard let movieImage = moviesDataModel[index].poster_path else { return }
            imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movieImage)"), completed: nil)
            imageView.isUserInteractionEnabled = true
            imageView.tag = index
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage(_:)))
            imageView.addGestureRecognizer(tap)
        }
        
        setPageControl()
        setScrollView()
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let index = CGFloat(self.pageControl.currentPage) * moviesScrollView.frame.size.width
        moviesScrollView.setContentOffset(CGPoint(x: index, y: 0), animated: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func tappedImage(_ sender: UITapGestureRecognizer? = nil) {
        let tappedImage = sender?.view as! UIImageView
        let index = tappedImage.tag
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailScreenViewController") as? DetailScreenViewController
        controller?.movieId = dataSource.moviesDataArray(self)[index].id
        viewController.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func setPageControl() {
        self.pageControl.numberOfPages = dataSource.moviesDataArray(self).count
        self.pageControl.hidesForSinglePage = true
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = "474954".hexColor
        self.pageControl.currentPageIndicatorTintColor = .white
        if #available(iOS 14.0, *) {
            self.pageControl.backgroundStyle = .minimal
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setScrollView() {
        self.moviesScrollView.showsVerticalScrollIndicator = false
        self.moviesScrollView.showsHorizontalScrollIndicator = false
        self.moviesScrollView.contentSize = CGSize(width: Int(UIScreen.main.bounds.size.width) * dataSource.moviesDataArray(self).count, height: Int())
        self.moviesScrollView.isPagingEnabled = true
    }
}


extension MoviesListHeaderTableViewCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.reloadData()
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        currentPageNumber = pageNumber
        self.pageControl.currentPage = Int(pageNumber)
    }
}

