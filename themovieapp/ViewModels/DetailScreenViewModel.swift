//
//  DetailScreenViewModel.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import Foundation
import UIKit
import SDWebImage
import SafariServices

class DetailScreenViewModel: NSObject {
    
    var movieImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var view: UIView!
    var viewController: BaseViewController!
    var moviesDetailModel: MoviesDetailResponse!
    var imdb_id: String?
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    func setDetailLayouts(viewController: BaseViewController, movieId: Int) {
        self.view = viewController.view
        self.viewController = viewController
        getListValueFromApi(movieId: movieId)
    }
    
    func getListValueFromApi(movieId: Int) {
        NetworkManager.sharedManager.getMoviesDetail(moviesId: movieId) { [self] response in
            moviesDetailModel = response
            setScrollView()
        } errorHandler: { [self] error in
            viewController.showErrorDialog()
        }
    }
    
    func setScrollView() {
        detailScrollView.delegate = self
        
        movieImageView.frame = CGRect(x: 0, y: 0, width: detailScrollView.frame.width, height: detailScrollView.frame.width)
        detailScrollView.insertSubview(movieImageView, at: 0)
        
        guard let image = moviesDetailModel.poster_path else { return }
        movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(image)"), completed: nil)
        
        let imdbLogoView: UIImageView = UIImageView(frame: CGRect(x: 20, y: detailScrollView.frame.width + 20, width: 70, height: 30))
        imdbLogoView.image = UIImage(named: "IMDBLogo")
        imdbLogoView.isUserInteractionEnabled = true
        self.imdb_id = moviesDetailModel.imdb_id
        let tapIMDBLogo = UITapGestureRecognizer(target: self, action: #selector(self.imdbLogoTapped(_:)))
        imdbLogoView.addGestureRecognizer(tapIMDBLogo)
        detailScrollView.insertSubview(imdbLogoView, at: 0)
        
        let rateLogo: UIImageView = UIImageView(frame: CGRect(x: 110, y: detailScrollView.frame.width + 25, width: 20, height: 20))
        rateLogo.image = UIImage(named: "Rate Icon")
        detailScrollView.insertSubview(rateLogo, at: 0)
        
        let imdbRatingLabel: UILabel = UILabel(frame: CGRect(x: 140, y: detailScrollView.frame.width + 20, width: 50, height: 30))
        imdbRatingLabel.textColor = .black
        guard let vote_average = moviesDetailModel.vote_average else { return }
        let voteAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.black , NSAttributedString.Key.font: UIFont(name: "Gilroy-Bold", size: 13) ?? UIFont.boldSystemFont(ofSize: 13) ]
        let voteAttrString = NSAttributedString(string: "\(vote_average)", attributes: voteAttribute)
        let decimalAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Gilroy-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13) ]
        let decimalAttrString = NSAttributedString(string: "/10", attributes: decimalAttribute)
        let imdbLabelString  = NSMutableAttributedString()
        imdbLabelString.append(voteAttrString)
        imdbLabelString.append(decimalAttrString)
        imdbRatingLabel.attributedText = imdbLabelString
        detailScrollView.insertSubview(imdbRatingLabel, at: 0)
        
        let yellowPoint: UIImageView = UIImageView(frame: CGRect(x: 200, y: detailScrollView.frame.width + 32, width: 5, height: 5))
        yellowPoint.image = UIImage(named: "noun_point_822231")
        detailScrollView.insertSubview(yellowPoint, at: 0)
        
        let releaseDateLabel = UILabel()
        guard let releaseDate = moviesDetailModel.release_date else { return }
        releaseDateLabel.setLabelProperties(frame: CGRect(x: 225, y: detailScrollView.frame.width + 20, width: 100, height: 30),
                                            text: releaseDate,
                                            textColor: .black,
                                            font: "Gilroy-Bold",
                                            fontSize: 13) { [self] in
            detailScrollView.insertSubview(releaseDateLabel, at: 0)
        }
        
        let movieTitleLabel = UILabel()
        guard let movieTitle = moviesDetailModel.original_title else { return }
        movieTitleLabel.setLabelProperties(frame: CGRect(x: 20, y: detailScrollView.frame.width + 70, width: detailScrollView.frame.width - 40, height: 60), text: movieTitle,
                                           textColor: .black,
                                           font: "DMSans-Bold",
                                           fontSize: 22) { [self] in
            detailScrollView.insertSubview(movieTitleLabel, at: 0)
            
        }
        
        let movieDetailTextView = UITextView()
        guard let movieDetail = moviesDetailModel.overview else { return }
        movieDetailTextView.setTextViewProperties(frame: CGRect(x: 20, y: detailScrollView.frame.width + 130, width: detailScrollView.frame.width - 40, height: 370),
                                                  text: movieDetail,
                                                  textColor: .black,
                                                  backgroundColor: .white,
                                                  font: "DMSans-Medium",
                                                  fontSize: 17) { [self] in
            detailScrollView.insertSubview(movieDetailTextView, at: 0)
            
        }
        viewController.requestStatus = .completed
    }
    
    @objc func imdbLogoTapped(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        guard let imdb_ids = imdb_id else { return }
        guard let url = URL(string: "https://www.imdb.com/title/\(imdb_ids)/") else { return }
        let svc = SFSafariViewController(url: url)
        self.viewController.present(svc, animated: true, completion: nil)
    }
}


extension DetailScreenViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          
          // Exit early if swiping up (scrolling down)
          if scrollView.contentOffset.y > 0 { return }
          
          // this is just a demo method on how to compute the scale factor based on the current contentOffset
          
          var scale = 1.0 + abs(scrollView.contentOffset.y)  / scrollView.frame.size.height
          
          //Cap the scaling between zero and 1
          scale = max(0.0, scale)
                    
      }
}
