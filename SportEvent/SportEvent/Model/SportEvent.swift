//
//  SportEvent.swift
//  SportEvent
//
//  Created by Dominik on 29.11.2023..
//

import Foundation

// MARK: - Welcome
struct SportEvent: Codable {
    let game: Game
}

// MARK: - Game
struct Game: Codable {
    let tournaments: [TournamentElement]
}

// MARK: - TournamentElement
struct TournamentElement: Codable {
    let tournament: TournamentTournament
    let events: [Event]
}

struct TournamentTournament: Codable {
    let name: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name, id
    }
}

// MARK: - Event
struct Event: Codable {
    let customID: String
    let homeTeam, awayTeam: Team
    let id: Int
    let startTimestamp: Int

    enum CodingKeys: String, CodingKey {
        case customID = "customId"
        case homeTeam, awayTeam, id, startTimestamp
    }
}

// MARK: - Team
struct Team: Codable {
    let name, slug, shortName, gender: String
    let nameCode: String
    let disabled, national: Bool
    let id: Int
}
