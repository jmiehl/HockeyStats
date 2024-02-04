//
//  HockeyPlayerModel.swift
//  HockeyStats
//
//  Created by Joe Miehl on 1/24/24.
//

import Foundation

struct HockeyPlayer {
    var firstName: String
    var lastName: String
    var position: String
    var goals: Int
    var assists: Int
    var points: Int
    var gamesPlayed: Int
   
    init(firstName: String, lastName: String, position: String, goals: Int, assists: Int, points: Int, gamesPlayed: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.goals = goals
        self.assists = assists
        self.points = points
        self.gamesPlayed = gamesPlayed
    }
    
}
