//
//  NormalTableViewCell.swift
//  MovieDatabaseApp
//
//  Created by Narayana on 30/06/24.
//

import UIKit

class NormalTableViewCell: UITableViewCell {
    static let cellIdentifier = "NormalTableViewCell"
    @IBOutlet var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(item: Any) {
        if let title = item as? String {
            self.lblTitle.text = title
        }
    }
    
}
