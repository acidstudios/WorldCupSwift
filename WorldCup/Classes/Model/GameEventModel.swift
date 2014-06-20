//
//  GameEventModel.swift
//  WorldCup
//
//  Created by Acid Studios on 20/06/14.
//  Copyright (c) 2014 Acid Studios. All rights reserved.
//

import UIKit

class GameEventModel: NSObject {
    var id:Int = 0
    var type_of_event: String = ""
    var player: String = ""
    var time: String = ""
    
    init(dict: NSDictionary)  {
        self.id = dict["id"] as Int
        self.type_of_event = dict["type_of_event"] as String
        self.player = dict["player"] as String
        self.time = dict["time"] as String
    }
    
    init()  {}
}
