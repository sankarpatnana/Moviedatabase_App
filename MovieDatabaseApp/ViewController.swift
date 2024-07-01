//
//  ViewController.swift
//  MovieDatabaseApp
//
//  Created by Narayana on 28/06/24.
//

import UIKit
struct MovieTypeData {
    var type:String?
    var isSelected: Bool?
    var isExpanded: Bool = false
}

enum ItemType {
    case year
    case gerne
    case directors
    case actors
    case allItmes
}

struct SectionInfo {
    var title: String
    var type: ItemType = .year
    var items: [Any]
    var isExpanded = false
}


class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var displayDataSource = [SectionInfo]()
    var allMovies = [MovieItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load JSON data
        readJSONFile()
        
        // Set navigation title
        navigationItem.title = "Movie Database"
        tableView.register(UINib(nibName: NormalTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: NormalTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: MovieItemTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MovieItemTableViewCell.cellIdentifier)
    }
    func readJSONFile() {
        if let path = Bundle.main.path(forResource: "movies", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                allMovies = try JSONDecoder().decode([MovieItem].self, from: data)
                
                //All Years
                var allUniqueYears   = [String]()
                let allYears = allMovies.compactMap{ item in
                    if item.year != "N/A" {
                        return String(item.released?.suffix(4) ?? "")
                    } else {
                        return nil
                    }
                }
                
                allUniqueYears = Array(Set(allYears))
                if allUniqueYears.count > 0 {
                    let diretorsSection = SectionInfo(title: "Years", type: .year, items: allUniqueYears)
                    displayDataSource.append(diretorsSection)
                }
                
                //Gerne Logic
                let allGenre = allMovies.compactMap{ item in
                    if item.actors != "N/A" {
                        return item.genre
                    } else {
                        return nil
                    }
                }
                if let items = allGenre as? [String] {
                    let uniqueDir = Array(Set(items.joined(separator: ", ").components(separatedBy: ", ")))
                    let diretorsSection = SectionInfo(title: "Gerne", type: .gerne, items: uniqueDir)
                    displayDataSource.append(diretorsSection)
                }
                
                //Directors Logic
                let allDirectors = allMovies.compactMap{ item in
                    if item.actors != "N/A" {
                        return item.director
                    } else {
                        return nil
                    }
                }
                if let items = allDirectors as? [String] {
                    let uniqueDir = Array(Set(items.joined(separator: ", ").components(separatedBy: ", ")))
                    let diretorsSection = SectionInfo(title: "Directors", type: .directors, items: uniqueDir)
                    displayDataSource.append(diretorsSection)
                }
                
                
                //Actors Logic
                let allActors = allMovies.compactMap{ item in
                    if item.actors != "N/A" {
                        return item.actors
                    } else {
                        return nil
                    }
                }
                if let items = allActors as? [String] {
                    let uniqueDir = Array(Set(items.joined(separator: ", ").components(separatedBy: ", ")))
                    
                    let diretorsSection = SectionInfo(title: "Actors", type: .actors, items: uniqueDir)
                    displayDataSource.append(diretorsSection)
                }
                
                //All Movies Logic
                if allMovies.count > 0 {
                    var diretorsSection = SectionInfo(title: "All Movies", items: allMovies)
                    diretorsSection.type = .allItmes
                    displayDataSource.append(diretorsSection)
                }
                tableView.reloadData()
                print("displayDataSource ==", displayDataSource)
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        } else {
            print("JSON file not found.")
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if displayDataSource[indexPath.section].type == .year  || displayDataSource[indexPath.section].type == .gerne || displayDataSource[indexPath.section].type == .directors || displayDataSource[indexPath.section].type == .actors {
            let cell = tableView.dequeueReusableCell(withIdentifier: NormalTableViewCell.cellIdentifier, for: indexPath) as!  NormalTableViewCell
            cell.configCell(item: displayDataSource[indexPath.section].items[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieItemTableViewCell.cellIdentifier, for: indexPath) as! MovieItemTableViewCell
            cell.configCell(item: displayDataSource[indexPath.section].items[indexPath.row])
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        displayDataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if displayDataSource[section].isExpanded {
            return displayDataSource[section].items.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white
        headerView.tag = section
        let label = UILabel()
        label.frame = CGRect.init(x: 10, y: 5, width: headerView.frame.width - 60, height: headerView.frame.height-10)
        label.text = displayDataSource[section].title
        label.font = .boldSystemFont(ofSize: 25)
        headerView.addSubview(label)
        
        let image = UIImageView()
        image.frame = CGRect.init(x: headerView.frame.width - 50, y: 10, width: 40, height: 40)
        image.contentMode = .scaleAspectFit
        image.image = displayDataSource[section].isExpanded ? UIImage(systemName: "chevron.down") :  UIImage(systemName: "chevron.forward")
        image.tintColor = .black
        headerView.addSubview(image)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        headerView.addGestureRecognizer(tap)
        
        return headerView
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        for index in 0 ..< displayDataSource.count {
            if index == sender?.view?.tag, displayDataSource[index].isExpanded == false {
                displayDataSource[index].isExpanded = true
            } else {
                displayDataSource[index].isExpanded = false
            }
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch displayDataSource[indexPath.section].type {
        case .year, .gerne, .actors, .directors:
            if let allMovies = self.getFilterdMovies(indexPath: indexPath, type: displayDataSource[indexPath.section].type) {
                //redirect to movie list
                print("allMovies ===", allMovies)
            }
        case .allItmes:
            if let currentMovie = displayDataSource[indexPath.section].items[indexPath.row] as? MovieItem {
                //redirect to detail
            }
        }
    }
    func getFilterdMovies(indexPath: IndexPath, type: ItemType) -> [MovieItem]? {
        var allmovies: [MovieItem]?
        if let currentItem = displayDataSource[indexPath.section].items[indexPath.row] as? String {
            allmovies = self.allMovies.filter({ item in
                switch type {
                case .year:
                    let year = String(item.released?.suffix(4) ?? "")
                    if year.count > 0 {
                        return year == currentItem
                    } else {
                        return false
                    }
                case .gerne:
                    return item.genre?.contains(currentItem) ?? false
                case .directors:
                    return item.director?.contains(currentItem) ?? false
                case .actors:
                    return item.actors?.contains(currentItem) ?? false
                default :
                    return false
                }
            })
        }
        return allmovies
    }
}
