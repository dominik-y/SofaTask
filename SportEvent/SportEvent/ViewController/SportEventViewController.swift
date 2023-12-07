//
//  ViewController.swift
//  SportEvent
//
//  Created by Dominik on 27.11.2023..
//

import UIKit
import Foundation

class SportEventViewController: UIViewController, UIScrollViewDelegate {
    
    private var viewController = ViewController()
    private var favoritesViewConroler = FavoritesViewController()
    private var sportEventsViewModel = SportEventViewModel()
    let refreshControl = UIRefreshControl()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SportEventTableViewCell.self,
                           forCellReuseIdentifier: SportEventTableViewCell.reuseId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        getEventsName()
    }
    
    func tableViewLayout() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func pullToRefresh() {
        ApiService.getEventIds(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let ids):
                self.sportEventsViewModel.data = []
                self.sportEventsViewModel.data.append(contentsOf: ids)
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            case .failure(_):
                break
            }
        })
    }
    
    func getEventsName() {
        ApiService.getEventIds(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let ids):
                self.sportEventsViewModel.data = []
                self.sportEventsViewModel.data.append(contentsOf: ids)
                tableViewLayout()
            case .failure(_):
                break
            }
        })
    }
}

extension SportEventViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sportEventsViewModel.data.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SportEventTableViewCell.reuseId, for: indexPath) as! SportEventTableViewCell
            
            ApiService.getEvent(id: sportEventsViewModel.data[indexPath.row]) { result in
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
        let eventDetailsViewController = EventDetailsViewController(id: sportEventsViewModel.data[indexPath.row])
        eventDetailsViewController.modalPresentationStyle = .fullScreen
        present(eventDetailsViewController, animated: true, completion: nil)
    }
}
