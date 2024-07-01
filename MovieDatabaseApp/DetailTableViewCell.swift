//
//  DetailTableViewCell.swift
//  MovieDatabaseApp
//
//  Created by Narayana on 01/07/24.
//

import UIKit
import Kingfisher

class DetailTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "DetailTableViewCell"
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var plotLbl: UILabel!
    @IBOutlet var castLbl: UILabel!
    @IBOutlet var releasedLbl: UILabel!
    @IBOutlet var genreLbl: UILabel!
    @IBOutlet var ratingLbl: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(item: Any) {
        if let item = item as? MovieItem {
            imgView.kf.setImage(with: URL(string: item.poster ?? ""))
            titleLbl.text  = item.title
            plotLbl.text = item.plot
            castLbl.text = item.actors
            releasedLbl.text = item.released
            genreLbl.text = item.genre
//            ratingLbl.text = item.imdbRating
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
