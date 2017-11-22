//
//  GameHandler.swift
//  Jumper
//
//  Created by Semen Parhimchik on 2016-08-12.
//  Copyright © 2016 Parhim. All rights reserved.
//

import Foundation

class GameHandler {
    var score:Int
    var highScore:Int
    var flowers:Int
    
    var levelData:NSDictionary!
    
    class var sharedInstance:GameHandler{
        struct Singleton{
            static let instance = GameHandler()
        }
        return Singleton.instance
    }
    
    init(){
        score = 0
        highScore = 0
        flowers = 0
        
        let userDefaulfts = UserDefaults.standard
        highScore = userDefaulfts.integer(forKey: "highScore")
        flowers = userDefaulfts.integer(forKey: "flowers")
        
        if let path = Bundle.main.path(forResource: "Level01", ofType: "plist"){
            if let level = NSDictionary(contentsOfFile: path){
                levelData = level
            }
        }
    }
    
    func saveGameStats(){
        highScore = max(score, highScore)
        
        let userDefaulfts = UserDefaults.standard
        userDefaulfts.set(highScore, forKey: "highScore")
        userDefaulfts.set(flowers, forKey: "flowers")
        userDefaulfts.synchronize()
    }
}
