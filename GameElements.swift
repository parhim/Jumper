//
//  GameElements.swift
//  Jumper
//
//  Created by Semen Parhimchik on 2016-08-11.
//  Copyright © 2016 Parhim. All rights reserved.
//
import Foundation
import SpriteKit

extension GameScene{
    func createBackgroud() -> SKNode{
        let backgroundNode = SKNode()
        let spacing = 64 * scaleFactor
        
        for index in 0...32{
        let node = SKSpriteNode(imageNamed: String(format: "Backgound%02d",index + 1))
        node.setScale(scaleFactor)
            node.anchorPoint = CGPoint(x: 0.5,y:0)
            node.position = CGPoint(x: self.size.width/2, y: spacing*CGFloat(index))
            
            backgroundNode.addChild(node)
        }
        for lap in 1...50{
        for index in 28...32{
            let node = SKSpriteNode(imageNamed: String(format: "Backgound%02d",index + 1))
            node.setScale(scaleFactor)
            node.anchorPoint = CGPoint(x: 0.5,y:0)
            node.position = CGPoint(x: self.size.width/2, y: spacing*CGFloat(index + (4 * lap)))
            
            backgroundNode.addChild(node)
            }}
        
        return backgroundNode
        
    }
    
    func createMidground()->SKNode{
        let midgroundNode = SKNode()
        var anchor:CGPoint!
        var xPos:CGFloat!
        
        for index in 0 ... 8{
            var name:String
            let randomN = arc4random()%2
            if randomN > 0 {
                name = "cloudLeft"
                anchor = CGPoint(x: 0, y: 0.5)
                xPos = 0;
            } else {
                name = "cloudRight"
                anchor = CGPoint(x: 1, y: 0.5)
                xPos = self.size.width;
            }
            let cloudNode = SKSpriteNode(imageNamed:name)
            cloudNode.anchorPoint = anchor
            cloudNode.position = CGPoint(x: xPos, y: 500 * CGFloat(index))
            midgroundNode.addChild(cloudNode)
        }
        return midgroundNode
    }
    
    func createPlayer()->SKNode{
        let playerNode = SKNode();
        playerNode.position = CGPoint(x: self.size.width/2, y: 80)
        
        let sprite = SKSpriteNode(imageNamed: "Player")
        playerNode.addChild(sprite)
        
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height/2)
        
        //gravity
        playerNode.physicsBody?.isDynamic = false
        
        playerNode.physicsBody?.allowsRotation = false
        playerNode.physicsBody?.restitution = 1
        playerNode.physicsBody?.friction = 0
        playerNode.physicsBody?.angularDamping = 0
        playerNode.physicsBody?.linearDamping = 0
        playerNode.physicsBody?.usesPreciseCollisionDetection = true
        playerNode.physicsBody?.categoryBitMask = CollisionBitMask.Player
        playerNode.physicsBody?.collisionBitMask = 0
        playerNode.physicsBody?.contactTestBitMask = CollisionBitMask.Flower | CollisionBitMask.Brick
        
        return playerNode
    }
    
    
    func createPlatformAtPosition(_ position:CGPoint, ofType type:PlatformType) -> PlatformNode{
        let node = PlatformNode()
        let position = CGPoint(x: position.x * scaleFactor, y: position.y)
        node.position = position
        node.name = "PLATFORMNODE"
        node.platformType = type
        
        var sprite:SKSpriteNode
        if type == PlatformType.normalBrick{
            sprite = SKSpriteNode(imageNamed: "Platform")
        } else {
            sprite = SKSpriteNode(imageNamed: "PlatformBreak")
        }
        
        node.addChild(sprite)
        
        node.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionBitMask.Brick
        node.physicsBody?.collisionBitMask = 0
        

        return node
    }
    
    
    func createFlowerAtPosition(_ position:CGPoint, ofType type:FlowerType) -> FlowerNode{
        let node = FlowerNode()
        let position = CGPoint(x: position.x * scaleFactor, y: position.y)
        node.position = position
        node.name = "FLOWERNODE"
        node.flowerType = type
        
        var sprite:SKSpriteNode
        if type == FlowerType.normalFlower{
            sprite = SKSpriteNode(imageNamed: "flower")
        } else {
            sprite = SKSpriteNode(imageNamed: "flowerSpecial")
        }
        
        node.addChild(sprite)
        
        node.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height/2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionBitMask.Flower
        node.physicsBody?.collisionBitMask = 0
        
        
        return node
    }
    
    
    
    
    
    
    
    
}
