import Foundation
import UIKit
import Alamofire

class FavoritesViewController: UIViewController {
    
    private var favoritesTableViewCell = FavoritesTableViewCell()
    private var sportEventViewModel = SportEventViewModel()
    
    var dateLabel = UILabel()
    var leaugeLabel = UILabel()
    
    private let favoritesEventTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(FavoritesTableViewCell.self,
                           forCellReuseIdentifier: FavoritesTableViewCell.reuseId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableViewLayout()
        self.view.addSubview(favoritesEventTableView)
    }
    
    func tableViewLayout() {
        favoritesEventTableView.dataSource = self
        favoritesEventTableView.delegate = self
        favoritesEventTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritesEventTableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sportEventViewModel.getAllFavorites()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportEventViewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseId, for: indexPath) as! FavoritesTableViewCell
        let dateLongVersion = Date(timeIntervalSince1970: TimeInterval(sportEventViewModel.favorites[indexPath.row].tournaments[0].events[0].startTimestamp))
        let dateShortVersion = dateLongVersion.formatted(date: .abbreviated, time: .shortened)
        
        cell.isUserInteractionEnabled = false
        cell.gameLabel.text = "\(sportEventViewModel.favorites[indexPath.row].tournaments[0].events[0].homeTeam.name) vs \(sportEventViewModel.favorites[indexPath.row].tournaments[0].events[0].awayTeam.name)"
        cell.dateLabel.text = dateShortVersion
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

