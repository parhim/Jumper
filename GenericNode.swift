//
//  GenericNode.swift
//  Jumper
//
//  Created by Semen Parhimchik on 2016-08-11.
//  Copyright © 2016 Parhim. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let Player:UInt32 = 0x00
    static let Flower:UInt32 = 0x01
    static let Brick:UInt32 = 0x02
    
}

enum PlatformType:Int{
    case normalBrick = 0
    case breakableBrick = 1
}

class GenericNode: SKNode {
    
    func collisionWithPlayer(_ player:SKNode)->Bool{
        
        return false
    }
    
    func shouldRemoveNode(_ playerY:CGFloat){
        if playerY > self.position.y + 300{
            self.removeFromParent()
        }
        
    }
}
