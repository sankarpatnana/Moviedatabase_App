//
//  MovieItemTableViewCell.swift
//  MovieDatabaseApp
//
//  Created by Narayana on 30/06/24.
//

import UIKit
import Kingfisher

class MovieItemTableViewCell: UITableViewCell {
    static let cellIdentifier = "MovieItemTableViewCell"
    @IBOutlet var imgMovie: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblLan: UILabel!
    @IBOutlet var lblYear: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMovie.tintColor = .black
        // Initialization code
    }
    func configCell(item: Any) {
        if let item = item as? MovieItem {
            imgMovie.contentMode = .scaleAspectFill
            lblTitle.text = item.title
            lblLan.text = item.language
            lblYear.text = "Year " + (item.year ?? "")
            if let urlStr = item.poster {
                if urlStr == "N/A" {
                    imgMovie.image = UIImage(systemName: "photo.fill")
                    imgMovie.contentMode = .scaleAspectFit
                } else {
                    let url = URL(string: urlStr)
                    imgMovie.kf.setImage(with: url, placeholder: UIImage(systemName: "photo.fill")) { result in
                        switch result {
                            case .success(let value):
                                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                            case .failure(_):
                            self.imgMovie?.contentMode = .scaleAspectFit
                            }
                    }
                }
                
            }
            
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
