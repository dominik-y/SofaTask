//
//  EventTableViewCell.swift
//  SportEvent
//
//  Created by Dominik on 06.12.2023..
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    static let reuseCellId = "EventCell"
    let teamsLabel = UILabel()
    let startTime = UILabel()
    var leaugeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(teamsLabel)
        self.addSubview(startTime)
        self.addSubview(leaugeLabel)
        
        teamsLabel.textAlignment = .center
        startTime.textAlignment = .center
        leaugeLabel.textAlignment = .center
        
//        leaugeLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(78)
//            make.width.equalToSuperview()
//            make.height.equalTo(30)
//            make.right.equalToSuperview().offset(6)
//            // fali horizontal
//        }
//        teamsLabel.snp.makeConstraints { make in
//            teamsLabel.textAlignment = .center
//            make.top.equalToSuperview().offset(200)
//            make.width.equalToSuperview()
//            make.height.equalTo(140)
//            make.right.equalToSuperview().offset(12)
//        }
//        startTime.snp.makeConstraints { make in
//            make.width.equalToSuperview().inset(10)
//            make.height.equalToSuperview().multipliedBy(0.5)
//            make.top.equalTo(teamsLabel.snp.bottom)
//            make.centerX.equalToSuperview()
//        }
    }
    
    func setLabelValues(homeTeam: String, awayTeam: String, start: Double) {
        let dateLongVersion = Date(timeIntervalSince1970: start)
        let dateShortVersion = dateLongVersion.formatted(date: .abbreviated, time: .shortened)
        leaugeLabel.text = "\(leaugeLabel)"
        teamsLabel.text = "\(homeTeam) vs a\(awayTeam)"
        startTime.text = "\(dateShortVersion)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



