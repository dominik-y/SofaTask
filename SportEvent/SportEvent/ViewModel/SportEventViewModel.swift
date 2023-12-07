//
//  SportEventViewModel.swift
//  SportEvent
//
//  Created by Dominik on 29.11.2023..
//

import Foundation

class SportEventViewModel {
    
    var data = [Int]()
    var resultList: [Int] = []
    var items: [Game] = []
    var apiService = ApiService()
    var gameList: [Game] = []
    var favorites: [Game] = []
    
    let defaults = UserDefaults.standard
    
    func fetchEventIds(completion: @escaping ([Int]) -> Void) {
        ApiService.getEventIds { result in
            switch result {
            case .success(let data):
                self.resultList = data
                //print("---------- \(self.resultList)")
                completion(data)
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func getAllFavorites() {
        for (key, _) in UserDefaults.standard.dictionaryRepresentation() {
            print(key)
            if key.contains("GameId:") {
                guard let data = UserDefaults.standard.data(forKey: key) else {
                    return
                }
                guard let obj = try? PropertyListDecoder().decode(Game.self, from: data) else {
                    return
                }
                favorites.append(obj)
            }
        }
    }
}
