//
//  GameScene.swift
//  Jumper
//
//  Created by Semen Parhimchik on 2016-08-11.
//  Copyright (c) 2016 Parhim. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var background:SKNode!
    var midgroud:SKNode!
    var foreground:SKNode!
    
    var hud:SKNode!
    
    var player:SKNode!
    
    var scaleFactor:CGFloat!
    
    var startButton = SKSpriteNode(imageNamed:"TapToStart")
    
    var endOfGamePosition = 0
    
    let motionManager = CMMotionManager()
    
    var xAcceleration:CGFloat = 0.0
    
    var scoreLabel:SKLabelNode!
    var flowerLabel:SKLabelNode!
    
    var playerMaxY:Int!
    
    var isGameOver = false
    
    let falling = SKSpriteNode(imageNamed: "PlayerFall")
    let norm = SKSpriteNode(imageNamed: "Player")
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size:CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor
        
        scaleFactor = self.size.width / 320
        
        let levelData = GameHandler.sharedInstance.levelData
        
        
        background = createBackgroud()
        addChild(background)
        
        midgroud = createMidground()
        addChild(midgroud)
        
        foreground = SKNode()
        addChild(foreground)
        
        player = createPlayer()
        foreground.addChild(player)
        
        let platforms = levelData["Platforms"] as! NSDictionary
        let platformPatterns = platforms["Patterns"] as! NSDictionary
        let platformPositions = platforms["Positions"] as! [NSDictionary]
        
        for platformPosition in platformPositions{
            let x = platformPosition["x"]?.floatValue
            let y = platformPosition["y"]?.floatValue
            let pattern = platformPosition["pattern"] as! NSString
            
            let platformPattern = platformPatterns[pattern] as! [NSDictionary]
            for platformPoint in platformPattern{
                let xValue = platformPoint["x"]?.floatValue
                let yValue = platformPoint["y"]?.floatValue
                let type = PlatformType(rawValue: platformPoint["type"]!.integerValue)
                let xPosition = CGFloat(xValue! + x!)
                let yPosition = CGFloat(yValue! + y!)
                
                let platformNode = createPlatformAtPosition(CGPoint(x: xPosition,y: yPosition), ofType: type!)
                
                foreground.addChild(platformNode)
            }
            
        }
        
        let flowers = levelData["Flowers"] as! NSDictionary
        let flowerPatterns = flowers["Patterns"] as! NSDictionary
        let flowerPositions = flowers["Positions"] as! [NSDictionary]
        
        for flowerPosition in flowerPositions{
            let x = flowerPosition["x"]?.floatValue
            let y = flowerPosition["y"]?.floatValue
            let pattern = flowerPosition["pattern"] as! NSString
            
            let flowerPattern = flowerPatterns[pattern] as! [NSDictionary]
            for flowerPoint in flowerPattern{
                let xValue = flowerPoint["x"]?.floatValue
                let yValue = flowerPoint["y"]?.floatValue
                let type = FlowerType(rawValue: flowerPoint["type"]!.integerValue)
                let xPosition = CGFloat(xValue! + x!)
                let yPosition = CGFloat(yValue! + y!)
                
                let flowerNode = createFlowerAtPosition(CGPoint(x: xPosition,y: yPosition), ofType: type!)
                
                foreground.addChild(flowerNode)
            }}
        
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (data:CMAccelerometerData?, error:NSError?)->Void in
            if let accelerometerData = data{
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = (CGFloat(acceleration.x) * 0.75 + (self.xAcceleration * 0.25))
            }
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var otherNode:SKNode!
        
        if contact.bodyA.node != player{
            otherNode = contact.bodyA.node
        } else {
            otherNode = contact.bodyB.node
        }
        
        (otherNode as! GenericNode).collisionWithPlayer(player)
        
    }
    
    override func didSimulatePhysics() {
        player.physicsBody?.velocity = CGVector(dx: xAcceleration * 400, dy: player.physicsBody!.velocity.dy)
    
        if player.position.x < -20 {
            player.position = CGPoint(x: self.size.width + 20, y: player.position.y)
        } else if (player.position.x>self.size.width+20){
            player.position = CGPoint(x: -20, y: player.position.y)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        player.physicsBody?.dynamic = true
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
    }
   
    override func update(currentTime: CFTimeInterval) {
        
        
        if player.position.y > 200 {
            background.position = CGPoint(x: 0, y: -((player.position.y - 200)/10))
            midgroud.position = CGPoint(x: 0, y: -((player.position.y - 200)/4))
            foreground.position = CGPoint(x: 0, y: -(player.position.y - 200))
            
        }
        
        if player.physicsBody?.velocity.dy < 0 {
        player.removeAllChildren()
        player.addChild(falling)
        } else {
        player.removeAllChildren()
        player.addChild(norm)
        }
    
    
    }
}
