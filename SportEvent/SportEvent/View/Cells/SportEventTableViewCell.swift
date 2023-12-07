//
//  EventTableViewCell.swift
//  SportEvent
//
//  Created by Dominik on 03.12.2023..
//

import UIKit
import SnapKit

class SportEventTableViewCell: UITableViewCell {
    
    static let reuseId = "SportEventCell"
    let gameLabel = UILabel()
    let startTime = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(gameLabel)
        self.addSubview(startTime)
        
        gameLabel.textAlignment = .center
        startTime.textAlignment = .center
        
        gameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        startTime.snp.makeConstraints { make in
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
        startTime.text = "\(dateShortVersion)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
