//
//  PlatformNode.swift
//  Jumper
//
//  Created by Semen Parhimchik on 2016-08-11.
//  Copyright © 2016 Parhim. All rights reserved.
//

import SpriteKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class PlatformNode: GenericNode {
    
    var platformType:PlatformType!
    
    override func collisionWithPlayer(_ player: SKNode) -> Bool {
        if player.physicsBody?.velocity.dy<0 {
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 350)
            if platformType == PlatformType.breakableBrick{
                self.removeFromParent()
            }
        }
        return true
    }
    
}
