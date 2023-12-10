import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    static let reuseId = "FavoritesCell"
    let gameLabel = UILabel()
    let dateLabel = UILabel()
    let teamsLabel = UILabel()
    var leagueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(gameLabel)
        self.addSubview(dateLabel)
        
        gameLabel.textAlignment = .center
        dateLabel.textAlignment = .center
        
        gameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(gameLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    func setLabelValues(homeTeam: String, awayTeam: String, start: Double) {
        let dateLongVersion = Date(timeIntervalSince1970: start)
        let dateShortVersion = dateLongVersion.formatted(date: .abbreviated, time: .shortened)
        gameLabel.text = "\(homeTeam) vs \(awayTeam)"
        dateLabel.text = "\(dateShortVersion)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



