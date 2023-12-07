//
//  FavoritesViewController.swift
//  SportEvent
//
//  Created by Dominik on 01.12.2023..
//

import Foundation
import UIKit
import Alamofire

class FavoritesViewController: UIViewController {
    
    private var sportEventViewModel = SportEventViewModel()
    
    // Table view sa elementima iz sportEventViewModel.favorites
//    private let favoritesEventTableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.register(EventTableViewCell.self,
//                           forCellReuseIdentifier: EventTableViewCell.reuseCellId)
//        return tableView
//    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       // self.view.addSubview(favoritesEventTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sportEventViewModel.getAllFavorites()
    }
}


extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sportEventViewModel.favorites.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SportEventTableViewCell.reuseId, for: indexPath) as! SportEventTableViewCell
            
            ApiService.getEvent(id: sportEventViewModel.data[indexPath.row]) { result in
                switch result {
                case .success(let success):
                    cell.setLabelValues(homeTeam: success.game.tournaments[0].events[0].homeTeam.name, awayTeam: success.game.tournaments[0].events[0].awayTeam.name, start: Double(success.game.tournaments[0].events[0].startTimestamp))
                case .failure(_):
                    break
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SportEventTableViewCell.reuseId, for: indexPath)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else {
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetailsViewController = EventDetailsViewController(id: sportEventViewModel.data[indexPath.row])
        eventDetailsViewController.modalPresentationStyle = .fullScreen
        present(eventDetailsViewController, animated: true, completion: nil)
    }
}

