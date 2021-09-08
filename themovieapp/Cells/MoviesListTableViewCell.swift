//
//  MoviesListTableViewCell.swift
//  themovieapp
//
//  Created by adilcan on 7.09.2021.
//

import UIKit
import SDWebImage

protocol MoviesListTableViewCellDataSource {
    func imageForCell(_ cell: MoviesListTableViewCell) -> String
    func nameForCell(_ cell: MoviesListTableViewCell) -> String
    func overviewForCell(_ cell: MoviesListTableViewCell) -> String
    func releaseDateForCell(_ cell: MoviesListTableViewCell) -> String
}

class MoviesListTableViewCell: UITableViewCell {
    
    var dataSource: MoviesListTableViewCellDataSource?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var showMovieDetailsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        selectionStyle = .none
        movieImageView.setCornerRadius(radius: 10)
    }
    
    func reloadData(){
        guard let image = dataSource?.imageForCell(self) else { return }
        movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(image)"), completed: nil)
        movieNameLabel.text = dataSource?.nameForCell(self)
        movieOverviewLabel.text = dataSource?.overviewForCell(self)
        movieReleaseDateLabel.text = dataSource?.releaseDateForCell(self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
