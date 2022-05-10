

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    //HELP
    //nodes
    var gameNode: SKNode!
    var groundNode: SKNode!
    var backgroundNode: SKNode!
    var cactusNode: SKNode!
    var dinosaurNode: SKNode!
    var birdNode: SKNode!
    //random Change
    
    //score
    var scoreNode: SKLabelNode!
    var resetInstructions: SKLabelNode!
    var score = 0 as Int
    
    //sprites
    var dinoSprite: SKSpriteNode!
    
    //spawning vars
    var spawnRate = 1.5 as Double
    var timeSinceLastSpawn = 0.0 as Double
    
    //generic vars
    var groundHeight: CGFloat?
    var dinoYPosition: CGFloat?
    var groundSpeed = 500 as CGFloat
    
    //consts
    let dinoHopForce = 750 as Int
    let cloudSpeed = 50 as CGFloat
    let moonSpeed = 10 as CGFloat
    
    let background = 0 as CGFloat
    let foreground = 1 as CGFloat
    
    //collision categories
    let groundCategory = 1 << 0 as UInt32
    let dinoCategory = 1 << 1 as UInt32
    let cactusCategory = 1 << 2 as UInt32
    let birdCategory = 1 << 3 as UInt32
    
    override func didMove(to view: SKView) {
        
        let bGround = SKSpriteNode(imageNamed: "sahil.assets/dog")
            
        
        bGround.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(bGround)
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        
        //ground
        groundNode = SKNode()
        groundNode.zPosition = background
        createAndMoveGround()
        addCollisionToGround()
        
        //background elements
        backgroundNode = SKNode()
        backgroundNode.zPosition = background
       
        
        //dinosaur
        dinosaurNode = SKNode()
        dinosaurNode.zPosition = foreground
        createDinosaur()
        
        //cacti
        cactusNode = SKNode()
        cactusNode.zPosition = foreground
        
        //birds
        birdNode = SKNode()
        birdNode.zPosition = foreground
        
        //score
        score = 0
        scoreNode = SKLabelNode(fontNamed: "Arial")
        scoreNode.fontSize = 30
        scoreNode.zPosition = foreground
        scoreNode.text = "Score: 0"
        scoreNode.fontColor = SKColor.gray
        scoreNode.position = CGPoint(x: 150, y: 100)
        
        //reset instructions
        resetInstructions = SKLabelNode(fontNamed: "Arial")
        resetInstructions.fontSize = 50
        resetInstructions.text = "Tap to Restart"
            
        //resetInstructions.text.opacity(0)
        resetInstructions.position = CGPoint(x: 1000, y: 10000)
        
        //parent game node
        gameNode = SKNode()
        gameNode.addChild(groundNode)
        gameNode.addChild(backgroundNode)
        gameNode.addChild(dinosaurNode)
        gameNode.addChild(cactusNode)
        gameNode.addChild(birdNode)
        gameNode.addChild(scoreNode)
        gameNode.addChild(resetInstructions)
        self.addChild(gameNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(gameNode.speed < 1.0){
            resetGame()
            return
        }
        
        for _ in touches {
            /*make a boolean statement and calculate how long a jump is.
            Use the length of the jump and set boolean false for
            the time its in midair. Once it hits that timer, set boolean to true
             letting the dino able to jump agian
 */
            if let groundPosition = dinoYPosition {
                if dinoSprite.position.y <= groundPosition && gameNode.speed > 0 {
                    dinoSprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: dinoHopForce))
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(gameNode.speed > 0){
            groundSpeed += 0.3
            
            score += 1
            scoreNode.text = "Score: \(score/5)"
            
            if(currentTime - timeSinceLastSpawn > spawnRate){
                timeSinceLastSpawn = currentTime
                spawnRate = Double.random(in: 1.0 ..< 3.5)
                
                if(Int.random(in: 0...10) < 8){
                    spawnCactus()
                } /*else {
                    spawnBird()
                }*/
            }
        }
        if(score > 200){
            groundSpeed += 20
        }
         
         
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if(hitCactus(contact) || hitBird(contact)){
            
            resetInstructions.position = CGPoint(x: 1000, y: self.frame.midY)
            gameOver()
        }
    }
    
    func hitCactus(_ contact: SKPhysicsContact) -> Bool {
        return contact.bodyA.categoryBitMask & cactusCategory == cactusCategory ||
            contact.bodyB.categoryBitMask & cactusCategory == cactusCategory
    }
    
    
    
    func hitBird(_ contact: SKPhysicsContact) -> Bool {
        return contact.bodyA.categoryBitMask & birdCategory == birdCategory ||
                contact.bodyB.categoryBitMask & birdCategory == birdCategory
    }
    
    func resetGame() {
        gameNode.speed = 1.0
        timeSinceLastSpawn = 0.0
        groundSpeed = 500
        score = 0
        
        cactusNode.removeAllChildren()
        birdNode.removeAllChildren()
        
        resetInstructions.position = CGPoint(x: 1000, y: 10000)
        resetInstructions.fontColor = SKColor.cyan
        
        let sahilTexture1 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00001")
        let sahilTexture2 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00002")
        let sahilTexture3 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00003")
        let sahilTexture4 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00004")
        let sahilTexture5 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00005")
        let sahilTexture6 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00006")
        let sahilTexture7 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00007")
        let sahilTexture8 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00008")
        let sahilTexture9 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00009")
        let sahilTexture10 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00010")
        let sahilTexture11 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00011")
        let sahilTexture12 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00012")
        sahilTexture1.filteringMode = .nearest
        sahilTexture2.filteringMode = .nearest
        sahilTexture3.filteringMode = .nearest
        sahilTexture4.filteringMode = .nearest
        sahilTexture5.filteringMode = .nearest
        sahilTexture6.filteringMode = .nearest
        sahilTexture7.filteringMode = .nearest
        sahilTexture8.filteringMode = .nearest
        sahilTexture9.filteringMode = .nearest
        sahilTexture10.filteringMode = .nearest
        sahilTexture11.filteringMode = .nearest
        sahilTexture12.filteringMode = .nearest
 
        let runningAnimation = SKAction.animate(with: [sahilTexture1, sahilTexture2, sahilTexture3, sahilTexture4, sahilTexture5, sahilTexture6, sahilTexture7, sahilTexture8, sahilTexture9, sahilTexture10, sahilTexture11, sahilTexture12], timePerFrame: 0.05)
        
        dinoSprite.position = CGPoint(x: self.frame.size.width * 0.15, y: dinoYPosition!)
        dinoSprite.run(SKAction.repeatForever(runningAnimation))
    }
    
    func gameOver() {
        gameNode.speed = 0.0
        
        
        resetInstructions.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        resetInstructions.fontColor = SKColor.black
        
        let deadScale = 0.3 as CGFloat
        
        let deadDinoTexture = SKTexture(imageNamed: "sahil.assets/sahilStills/dead")
        deadDinoTexture.filteringMode = .nearest
        
        let deadDinoSprite = SKSpriteNode(texture: deadDinoTexture)
        deadDinoSprite.setScale(deadScale)
        
        dinoSprite.removeAllActions()
        dinoSprite.texture = deadDinoTexture
    }
    
    func createAndMoveGround() {
        let screenWidth = self.frame.size.width
        
        //ground texture
        let groundTexture = SKTexture(imageNamed: "sahil.assets/landscape/ground")
        groundTexture.filteringMode = .nearest
        
        groundHeight = groundTexture.size().height * 0.5
        
        //ground actions
        let moveGroundLeft = SKAction.moveBy(x: -groundTexture.size().width,
                                             y: 0.0, duration: TimeInterval(screenWidth / groundSpeed))
        let resetGround = SKAction.moveBy(x: groundTexture.size().width, y: 0.0, duration: 0.0)
        let groundLoop = SKAction.sequence([moveGroundLeft, resetGround])
        
        //ground nodes
        let numberOfGroundNodes = 1 + Int(ceil(screenWidth / groundTexture.size().width))
        
        for i in 0 ..< numberOfGroundNodes {
            let node = SKSpriteNode(texture: groundTexture)
            node.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            node.position = CGPoint(x: CGFloat(i) * groundTexture.size().width, y: groundHeight!)
            groundNode.addChild(node)
            node.run(SKAction.repeatForever(groundLoop))
        }
    }
    
    func addCollisionToGround() {
        let groundContactNode = SKNode()
        groundContactNode.position = CGPoint(x: 0, y: groundHeight! - 30)
        groundContactNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width * 3,
                                                                          height: groundHeight!))
        groundContactNode.physicsBody?.friction = 0.0
        groundContactNode.physicsBody?.isDynamic = false
        groundContactNode.physicsBody?.categoryBitMask = groundCategory
        
        groundNode.addChild(groundContactNode)
    }
    
    func createDinosaur() {
        //default is 3
        let screenWidth = self.frame.size.width
        let dinoScale = 0.5 as CGFloat
        
        //textures
        
               let sahilTexture1 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00001")
               let sahilTexture2 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00002")
               let sahilTexture3 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00003")
               let sahilTexture4 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00004")
               let sahilTexture5 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00005")
               let sahilTexture6 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00006")
               let sahilTexture7 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00007")
               let sahilTexture8 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00008")
               let sahilTexture9 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00009")
               let sahilTexture10 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00010")
               let sahilTexture11 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00011")
               let sahilTexture12 = SKTexture(imageNamed: "sahil.assets/sprint/frame_00012")
               sahilTexture1.filteringMode = .nearest
               sahilTexture2.filteringMode = .nearest
               sahilTexture3.filteringMode = .nearest
               sahilTexture4.filteringMode = .nearest
               sahilTexture5.filteringMode = .nearest
               sahilTexture6.filteringMode = .nearest
               sahilTexture7.filteringMode = .nearest
               sahilTexture8.filteringMode = .nearest
               sahilTexture9.filteringMode = .nearest
               sahilTexture10.filteringMode = .nearest
               sahilTexture11.filteringMode = .nearest
               sahilTexture12.filteringMode = .nearest
        
               let runningAnimation = SKAction.animate(with: [sahilTexture1, sahilTexture2, sahilTexture3, sahilTexture4, sahilTexture5, sahilTexture6, sahilTexture7, sahilTexture8, sahilTexture9, sahilTexture10, sahilTexture11, sahilTexture12], timePerFrame: 0.05)
               

        dinoSprite = SKSpriteNode()
        dinoSprite.size = sahilTexture1.size()
        dinoSprite.setScale(dinoScale)
        dinosaurNode.addChild(dinoSprite)
        
        let physicsBox = CGSize(width: sahilTexture1.size().width * dinoScale,
                                height: sahilTexture1.size().height * dinoScale)
        
        dinoSprite.physicsBody = SKPhysicsBody(rectangleOf: physicsBox)
        dinoSprite.physicsBody?.isDynamic = true
        dinoSprite.physicsBody?.mass = 1.0
        dinoSprite.physicsBody?.categoryBitMask = dinoCategory
        dinoSprite.physicsBody?.contactTestBitMask = birdCategory | cactusCategory
        dinoSprite.physicsBody?.collisionBitMask = groundCategory
        
        dinoYPosition = getGroundHeight() + sahilTexture1.size().height * dinoScale
        dinoSprite.position = CGPoint(x: screenWidth * 0.15, y: dinoYPosition!)
        dinoSprite.run(SKAction.repeatForever(runningAnimation))
    }
    
    func spawnCactus() {
        //default was 3
        let cactusTextures = ["barrel"]
        let cactusScale = 0.3 as CGFloat
        let hitBoxScale = 0.85 as CGFloat
        //texture
        let cactusTexture = SKTexture(imageNamed: "sahil.assets/obstacles/barrel")
        cactusTexture.filteringMode = .nearest
        
        //sprite
        let cactusSprite = SKSpriteNode(texture: cactusTexture)
        cactusSprite.setScale(cactusScale)
        
        //physics
        let contactBox = CGSize(width: cactusTexture.size().width * (cactusScale * hitBoxScale),
                                height: cactusTexture.size().height * (cactusScale * hitBoxScale))
        cactusSprite.physicsBody = SKPhysicsBody(rectangleOf: contactBox)
        cactusSprite.physicsBody?.isDynamic = false
        cactusSprite.physicsBody?.mass = 1.0
        cactusSprite.physicsBody?.categoryBitMask = cactusCategory
        cactusSprite.physicsBody?.contactTestBitMask = dinoCategory
        cactusSprite.physicsBody?.collisionBitMask = groundCategory
        
        //add to scene
        cactusNode.addChild(cactusSprite)
        //animate
        animateCactus(sprite: cactusSprite, texture: cactusTexture)
    }
    
    func animateCactus(sprite: SKSpriteNode, texture: SKTexture) {
        let cactusScale = 0.2 as CGFloat
        let screenWidth = self.frame.size.width
        let distanceOffscreen = 50.0 as CGFloat
        let distanceToMove = screenWidth + distanceOffscreen + texture.size().width
        
        //actions
        let moveCactus = SKAction.moveBy(x: -distanceToMove, y: 0.0, duration: TimeInterval(screenWidth / groundSpeed))
        let removeCactus = SKAction.removeFromParent()
        let moveAndRemove = SKAction.sequence([moveCactus, removeCactus])
        
        sprite.position = CGPoint(x: distanceToMove, y: getGroundHeight() + (texture.size().height * cactusScale))
        sprite.run(moveAndRemove)
    }
    
    func getGroundHeight() -> CGFloat {
        if let gHeight = groundHeight {
            return gHeight
        } else {
            print("Ground size wasn't previously calculated")
            exit(0)
        }
    }
    
}
