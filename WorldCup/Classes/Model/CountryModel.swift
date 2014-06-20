//
//  CountryModel.swift
//  WorldCup
//
//  Created by Acid Studios on 19/06/14.
//  Copyright (c) 2014 Acid Studios. All rights reserved.
//

import UIKit

class CountryModel: NSObject {
    var country: String? = ""
    var alternate_name: String? = ""
    var fifa_code: String? = ""
    var group_id:Int = 0
    var wins: Int? = 0
    var draws: Int? = 0
    var losses: Int? = 0
    var goals_for: Int? = 0
    var goals_against: Int? = 0
    var knocked_out: Int? = 0
    var goals: Int = 0
    
    init() {
        
    }
}
