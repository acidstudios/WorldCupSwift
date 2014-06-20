//
//  TomorrowModel.swift
//  WorldCup
//
//  Created by Acid Studios on 20/06/14.
//  Copyright (c) 2014 Acid Studios. All rights reserved.
//

import UIKit

class MatchModel: NSObject {
    var match_number: Int = 0
    var location: String = ""
    var datetime: String = ""
    var status: String = ""
    var home_team: CountryModel = CountryModel()
    var away_team: CountryModel = CountryModel()
    var home_team_events: GameEventModel[] = Array()
    var away_team_events: GameEventModel[] = Array()
    var winner: String? = ""
    
    init(dict: NSDictionary) {
        super.init()
        
        self.match_number = dict["match_number"] as Int
        self.location = dict["location"] as String
        self.status = dict["status"] as String
        self.datetime = dict["datetime"] as String
        self.winner = dict["winner"] as? String
        
        var away = dict["away_team"] as NSDictionary
        self.away_team = CountryModel()
        self.away_team.country = away["country"] as? String
        self.away_team.fifa_code = away["code"] as? String
        self.away_team.goals = away["goals"] as Int
        
        var home = dict["home_team"] as NSDictionary
        self.home_team = CountryModel()
        self.home_team.country = home["country"] as? String
        self.home_team.fifa_code = home["code"] as? String
        self.home_team.goals = home["goals"] as Int
        
        var home_team_events = dict["home_team_events"] as AnyObject[]
        var away_team_events = dict["away_team_events"] as AnyObject[]
        
        self.home_team_events = home_team_events.map {
            var event = GameEventModel(dict: $0 as NSDictionary)
            return event
        }
        
        self.away_team_events = away_team_events.map {
            var event = GameEventModel(dict: $0 as NSDictionary)
            return event
        }
        
    }
    
    init() {}
}
