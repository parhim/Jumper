//
//  FlowerNode.swift
//  Jumper
//
//  Created by Semen Parhimchik on 2016-08-11.
//  Copyright © 2016 Parhim. All rights reserved.
//

import SpriteKit

enum FlowerType:Int{
    case normalFlower = 0
    case specialFlower = 1
}

class FlowerNode: GenericNode {
    var flowerType:FlowerType!
    
    override func collisionWithPlayer(_ player: SKNode) -> Bool {
        if flowerType == FlowerType.normalFlower{
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400)}
        else{player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 500)}
        self.removeFromParent()
        return true
    }
}
