//
//  ApiService.swift
//  SportEvent
//
//  Created by Dominik on 29.11.2023..
//

import Foundation
import Alamofire

class ApiService {
    
    //static let shared = ApiService() - Singleton
    
    static func getEventIds(completion: @escaping (Result<[Int], Error>) -> Void) {
        let url = "https://api.sofascore.com/mobile/v4/unique-tournament/17/current-event-ids"
        
        //Dobaviti listu id-a
        AF.request(url).responseDecodable(of: [Int].self) { response in
            //print(response.result)
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(.failure(failure))
            }
        }
    }
    
    static func getEvent(id: Int, completion: @escaping (Result<SportEvent, Error>) -> Void) {
        let url = "https://api.sofascore.com/mobile/v4/event/\(id)/details"
        
        AF.request(url).responseDecodable(of: SportEvent.self) { response in
            //print(response.result)
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
