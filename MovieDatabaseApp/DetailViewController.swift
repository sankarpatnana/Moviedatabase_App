//
//  DetailViewController.swift
//  MovieDatabaseApp
//
//  Created by Narayana on 01/07/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var selectedMovie: MovieItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: DetailTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.cellIdentifier)
    }
    
}
