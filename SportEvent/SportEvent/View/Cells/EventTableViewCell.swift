import UIKit

class EventTableViewCell: UITableViewCell {
    
    static let reuseCellId = "EventCell"
    let teamsLabel = UILabel()
    let startTimeLabel = UILabel()
    var leagueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(teamsLabel)
        self.addSubview(startTimeLabel)
        self.addSubview(leagueLabel)
        
        teamsLabel.textAlignment = .center
        startTimeLabel.textAlignment = .center
        leagueLabel.textAlignment = .center
        leagueLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 24)
        
        leagueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(6)
        }
        teamsLabel.snp.makeConstraints { make in
            teamsLabel.textAlignment = .center
            make.top.equalToSuperview().offset(200)
            make.width.equalToSuperview()
            make.height.equalTo(140)
            make.right.equalToSuperview().offset(12)
        }
        startTimeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(380)
        }
    }
    
    func setLabelValues(league: String, homeTeam: String, awayTeam: String, start: Double) {
        let dateLongVersion = Date(timeIntervalSince1970: start)
        let dateShortVersion = dateLongVersion.formatted(date: .abbreviated, time: .shortened)
        teamsLabel.text = "\(homeTeam) vs \(awayTeam)"
        startTimeLabel.text = "\(dateShortVersion)"
        leagueLabel.text = "\(league)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



