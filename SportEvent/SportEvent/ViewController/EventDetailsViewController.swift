import Foundation
import UIKit

class EventDetailsViewController: UIViewController {
    
    var id: Int
    var game: Game?
    let favouriteIcon = UIImageView()
    let teamsLabel = UILabel()
    let backButton = UIButton(type: .system)
    let resultLabel = UILabel()
    var dateLabel = UILabel()
    var leaugeLabel = UILabel()
    
    private var sportEventViewModel = SportEventViewModel()
    private var favoritesViewController = FavoritesViewController()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(EventTableViewCell.self,
                           forCellReuseIdentifier: EventTableViewCell.reuseCellId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        tableViewLayout()
        backButtonDecorate()
        configureSubviews()
        setData()
        setupLayout()
        
        let favoriteGesture = UITapGestureRecognizer(target: self, action: #selector(favoritesTap))
        favouriteIcon.isUserInteractionEnabled = true
        favouriteIcon.addGestureRecognizer(favoriteGesture)
    }
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isKeyPresentInUserDefaults(key: "GameId:\(id)") {
            favouriteIcon.image = UIImage(systemName: "star.fill")
        } else {
            favouriteIcon.image = UIImage(systemName: "star")
        }
    }
    
    private func configureSubviews() {
        view.addSubview(backButton)
        view.addSubview(teamsLabel)
        view.addSubview(favouriteIcon)
        view.addSubview(leaugeLabel)
    }
    
    func tableViewLayout() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
    }
    
    private func setupLayout() {
        favouriteIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.height.width.equalTo(30)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    @objc func favoritesTap() {
        if isKeyPresentInUserDefaults(key: String(id)) {
            removeFavorite()
            favouriteIcon.image = UIImage(systemName: "star")
        } else {
            addFavorite()
            favouriteIcon.image = UIImage(systemName: "star.fill")
        }
    }
    
    private func setData() {
        ApiService.getEvent(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.teamsLabel.text = "\(success.game.tournaments[0].events[0].homeTeam.name) vs \(success.game.tournaments[0].events[0].awayTeam.name)"
                self.game = success.game
                self.leaugeLabel.text = success.game.tournaments[0].tournament.name
                self.dateLabel.text = String(success.game.tournaments[0].events[0].startTimestamp)
            case .failure(_):
                break
            }
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        guard let data = UserDefaults.standard.data(forKey: "GameId:\(id)") else {
            return false
        }
        
        guard (try? PropertyListDecoder().decode(Game.self, from: data)) != nil else {
            return false
        }
        return true
    }
    
    func addFavorite() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(game), forKey:"GameId:\(id)")
        
    }
    
    func removeFavorite() {
        sportEventViewModel.defaults.removeObject(forKey: "GameId:\(id)")
    }
    
    func backButtonDecorate() {
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        backButton.frame = CGRect(x: 20, y: 40, width: 60, height: 30)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: Extension
extension EventDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.reuseCellId) as! EventTableViewCell
        
        ApiService.getEvent(id: id) { result in
            switch result {
            case .success(let success):
                cell.setLabelValues(league: success.game.tournaments[0].tournament.name, homeTeam: success.game.tournaments[0].events[0].homeTeam.name, awayTeam: success.game.tournaments[0].events[0].awayTeam.name,
                                    start: Double(success.game.tournaments[0].events[0].startTimestamp))
                
            case .failure(_):
                break
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
}
