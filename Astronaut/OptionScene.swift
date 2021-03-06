//
//  OptionScene.swift
//  Astronaut
//
//  Created by Yannik Lauenstein on 24.08.15.
//  Copyright (c) 2015 YaLu. All rights reserved.
//

import SpriteKit

class OptionScene: SGScene {
    
    var redSlider: UISlider! = UISlider(frame: CGRectMake(20, 260, 280, 20))
    var greenSlider: UISlider! = UISlider(frame: CGRectMake(20, 260, 280, 20))
    var blueSlider: UISlider! = UISlider(frame: CGRectMake(20, 260, 280, 20))
    let bg = SKSpriteNode(imageNamed: "Background188")
    let bg2 = SKSpriteNode(imageNamed: "Background188")
    let bg3 = SKSpriteNode(imageNamed: "Background188")
    var bgAnimSpeed:CGFloat = 4
    let satelliteTexture:SKTexture = SKTexture(imageNamed: "Satellite15")
    let gameSpeed:CGFloat = 1
    var endOfScreenRight = CGFloat()
    var endOfScreenLeft = CGFloat()
    let coloredSprite = SKSpriteNode(imageNamed: "Astronaut25")
    let backSprite = SKSpriteNode(imageNamed: "BackButton32")
    let menuColorSprite = SKSpriteNode(imageNamed: "SecretButton32")
    let menuSoundSprite = SKSpriteNode(imageNamed: "SettingsButton32")
    let menuThemeSprite = SKSpriteNode(imageNamed: "ThemeButton32")
    var noAdSprite = SKSpriteNode(imageNamed: "RemoveAdsButton32")
    let soundSprite = SKSpriteNode(imageNamed: "SoundOnButton32")
    let musicSprite = SKSpriteNode(imageNamed: "MusicOnButton32")
    let buttonPressDark = SKAction.colorizeWithColor(UIColor.blackColor(), colorBlendFactor: 0.2, duration: 0.2)
    let buttonPressLight = SKAction.colorizeWithColor(UIColor.clearColor(), colorBlendFactor: 0, duration: 0.2)
    var soundOn:Bool = true
    var musicOn:Bool = true
    var adsDisabled:Bool = false
    var optionSceneActive = false
    var red:Float = 0
    var green:Float = 0
    var blue:Float = 0
    var lastSpriteName:String = ""
    var scalingFactor:CGFloat = 1
    var isSecretUnlocked:Bool = false
    var secretShown:Bool = false
    
    override func didMoveToView(view: SKView) {
        
        musicOn = interScene.musicState
        soundOn = interScene.soundState
        
        loadSoundState()

        endOfScreenLeft = (self.size.width / 2) * CGFloat(-1) - ((SKSpriteNode(texture: satelliteTexture).size.width / 2) * scalingFactor)
        endOfScreenRight = (self.size.width / 2) + ((SKSpriteNode(texture: satelliteTexture).size.width / 2) * scalingFactor)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OptionScene.hideAdsSuccess), name: "AdRemoveSuccess", object: nil)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.respondToSwipeGesture(_:)))
        swipeRight.direction = .Right
        self.view!.addGestureRecognizer(swipeRight)
        
        if interScene.deviceType == .IPhone || interScene.deviceType == .IPodTouch {
            scalingFactor = interScene.scalingfactoriPhone
        } else if interScene.deviceType == .IPadRetina || interScene.deviceType == .IPad {
            scalingFactor = interScene.scalingfactoriPad
        }
        
        self.backgroundColor = UIColor(rgba: "#1E2124")
        
        bg.zPosition = 0.9
        bg2.zPosition = 0.9
        bg3.zPosition = 0.9
        
        bg.setScale(scalingFactor)
        bg2.setScale(scalingFactor)
        bg3.setScale(scalingFactor)
        
        bg.texture?.filteringMode = .Nearest
        bg2.texture?.filteringMode = .Nearest
        bg3.texture?.filteringMode = .Nearest
        
        addChild(bg)
        bg.position.x = 0
        bg2.position.x = self.size.width
        bg3.position.x = self.size.width * 2
        addChild(bg2)
        addChild(bg3)
        
        isSecretUnlocked = NSUserDefaults.standardUserDefaults().boolForKey("secretUnlocked")
        
        redSlider = UISlider(frame: CGRectMake(self.size.width / 2 - 140, self.size.height / 6, 280, 20))
        redSlider.minimumValue = 0
        redSlider.maximumValue = 1
        redSlider.value = 1.0
        redSlider.continuous = true
        redSlider.tintColor = UIColor.redColor()
        redSlider.value = heroColor.heroColorRed
        redSlider.addTarget(self, action: #selector(OptionScene.sliderValueDidChange), forControlEvents: .ValueChanged)
        redSlider.alpha = 0
        redSlider.setThumbImage(UIImage(named: "Astronaut25"), forState: UIControlState.Normal)
        redSlider.setMinimumTrackImage(UIImage(named: "RedSlider3"), forState: UIControlState.Normal)
        redSlider.setMaximumTrackImage(UIImage(named: "GreySlider3"), forState: UIControlState.Normal)
        
        greenSlider = UISlider(frame: CGRectMake(self.size.width / 2 - 140, self.size.height / 3, 280, 20))
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 1
        greenSlider.value = 1.0
        greenSlider.continuous = true
        greenSlider.tintColor = UIColor.greenColor()
        greenSlider.value = heroColor.heroColorGreen
        greenSlider.addTarget(self, action: #selector(OptionScene.sliderValueDidChange), forControlEvents: .ValueChanged)
        greenSlider.alpha = 0
        greenSlider.alpha = 0
        greenSlider.setThumbImage(UIImage(named: "Astronaut25"), forState: UIControlState.Normal)
        greenSlider.setMinimumTrackImage(UIImage(named: "GreenSlider3"), forState: UIControlState.Normal)
        greenSlider.setMaximumTrackImage(UIImage(named: "GreySlider3"), forState: UIControlState.Normal)
        
        blueSlider = UISlider(frame: CGRectMake(self.size.width / 2 - 140, self.size.height / 2 , 280, 20))
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 1
        blueSlider.value = 1.0
        blueSlider.continuous = true
        blueSlider.tintColor = UIColor.blueColor()
        blueSlider.value = heroColor.heroColorBlue
        blueSlider.addTarget(self, action: #selector(OptionScene.sliderValueDidChange), forControlEvents: .ValueChanged)
        blueSlider.alpha = 0
        blueSlider.alpha = 0
        blueSlider.setThumbImage(UIImage(named: "Astronaut25"), forState: UIControlState.Normal)
        blueSlider.setMinimumTrackImage(UIImage(named: "BlueSlider3"), forState: UIControlState.Normal)
        blueSlider.setMaximumTrackImage(UIImage(named: "GreySlider3"), forState: UIControlState.Normal)
        
        coloredSprite.setScale(scalingFactor)
        coloredSprite.position.x = 0
        coloredSprite.position.y = -(self.size.height / 4)
        coloredSprite.zPosition = 1.2
        addChild(coloredSprite)
        coloredSprite.hidden = true
        coloredSprite.texture?.filteringMode = .Nearest
        
        noAdSprite.setScale(scalingFactor)
        noAdSprite.position.x = 0
        noAdSprite.position.y = -(self.size.height / 4)
        noAdSprite.zPosition = 1.2
        noAdSprite.name = "noAdSprite"
        addChild(noAdSprite)
        noAdSprite.texture?.filteringMode = .Nearest
        
        musicSprite.setScale(scalingFactor)
        musicSprite.position.x = -(self.size.width / 4 - musicSprite.size.width)
        musicSprite.position.y = self.size.height / 4 - musicSprite.size.height / 4
        musicSprite.zPosition = 1.2
        musicSprite.name = "musicSprite"
        if musicOn == true {
            musicSprite.texture = SKTexture(imageNamed: "MusicOnButton32")
        } else {
            musicSprite.texture = SKTexture(imageNamed: "MusicOffButton32")
        }
        addChild(musicSprite)
        musicSprite.texture?.filteringMode = .Nearest
        
        soundSprite.setScale(scalingFactor)
        soundSprite.position.x = self.size.width / 4 - soundSprite.size.width
        soundSprite.position.y = self.size.height / 4 - soundSprite.size.height / 4
        soundSprite.zPosition = 1.2
        soundSprite.name = "soundSprite"
        if soundOn == true {
            soundSprite.texture = SKTexture(imageNamed: "SoundOnButton32")
        } else {
            soundSprite.texture = SKTexture(imageNamed: "SoundOffButton32")
        }
        addChild(soundSprite)
        soundSprite.texture?.filteringMode = .Nearest
        
        backSprite.setScale(scalingFactor)
        backSprite.position.x = -((self.size.width / 2) - (backSprite.size.width / 2) - 20)
        backSprite.position.y = -(self.size.height / 4)
        backSprite.zPosition = 1.2
        backSprite.name = "backSprite"
        addChild(backSprite)
        backSprite.texture?.filteringMode = .Nearest
        
        menuColorSprite.setScale(scalingFactor)
        menuColorSprite.position.x = -((self.size.width / 2) - (backSprite.size.width / 2) - 20)
        menuColorSprite.position.y = menuColorSprite.size.height
        menuColorSprite.zPosition = 1.2
        menuColorSprite.name = "menuColorSprite"
        addChild(menuColorSprite)
        if isSecretUnlocked == true {
            menuColorSprite.hidden = false
            achievementSecretMenu()
        } else {
            menuColorSprite.hidden = true
        }
        menuColorSprite.texture?.filteringMode = .Nearest
            
        menuSoundSprite.setScale(scalingFactor)
        menuSoundSprite.position.x = (self.size.width / 2) - (menuSoundSprite.size.width / 2) - 20
        menuSoundSprite.position.y = -(menuSoundSprite.size.height)
        menuSoundSprite.zPosition = 1.2
        menuSoundSprite.name = "menuSoundSprite"
        addChild(menuSoundSprite)
        menuSoundSprite.hidden = true
        menuSoundSprite.texture?.filteringMode = .Nearest
        
        menuThemeSprite.setScale(scalingFactor)
        menuThemeSprite.position.x = (self.size.width / 2) - (menuThemeSprite.size.width / 2) - 20
        menuThemeSprite.position.y = menuThemeSprite.size.height
        menuThemeSprite.zPosition = 1.2
        menuThemeSprite.name = "menuThemeSprite"
        addChild(menuThemeSprite)
        menuThemeSprite.hidden = true
        menuThemeSprite.texture?.filteringMode = .Nearest
        
        sliderValueDidChange()
        adButtonSwitch()
        startBGAnim()
        optionSceneActive = true
    }
    
    func adButtonSwitch() {
        if interScene.adState == true {
            self.noAdSprite.texture = SKTexture(imageNamed: "RemoveAdsButton32")
        } else {
            self.noAdSprite.texture = SKTexture(imageNamed: "DRemoveAdsButton32")
        }
    }
    
    func startBGAnim() {
        bg.runAction(SKAction.moveToX(bg.position.x - self.size.width * 2 - SKSpriteNode(texture: satelliteTexture).size.width / 2, duration: NSTimeInterval(self.size.width / CGFloat(gameSpeed) / bgAnimSpeed)))
        bg2.runAction(SKAction.moveToX(bg2.position.x - self.size.width * 2 - SKSpriteNode(texture: satelliteTexture).size.width / 2, duration: NSTimeInterval(self.size.width / CGFloat(gameSpeed) / bgAnimSpeed)))
        bg3.runAction(SKAction.moveToX(bg3.position.x - self.size.width * 2 - SKSpriteNode(texture: satelliteTexture).size.width / 2, duration: NSTimeInterval(self.size.width / CGFloat(gameSpeed) / bgAnimSpeed)))
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                if secretShown == false {
                    showMenu()
                }
            case UISwipeGestureRecognizerDirection.Down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.Left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.Up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    func stopBGAnim() {
        bg.removeAllActions()
        bg2.removeAllActions()
        bg3.removeAllActions()
    }
    
    func updateBGPosition() {
        
        if bg.position.x <= endOfScreenLeft - self.size.width / 2{
            
            bg.position.x = self.size.width * 2
            stopBGAnim()
            startBGAnim()
            
        }
        if bg2.position.x <= endOfScreenLeft - self.size.width / 2{
            
            bg2.position.x = self.size.width * 2
            stopBGAnim()
            startBGAnim()
            
        }
        if bg3.position.x <= endOfScreenLeft - self.size.width / 2{
            
            bg3.position.x = self.size.width * 2
            stopBGAnim()
            startBGAnim()
            
        }
    }

    func showThemeMenu() {
        resetSecret()
        soundSprite.runAction(SKAction.fadeOutWithDuration(1.0))
        musicSprite.runAction(SKAction.fadeOutWithDuration(1.0))
        coloredSprite.runAction(SKAction.fadeOutWithDuration(1.0))
        noAdSprite.runAction(SKAction.fadeOutWithDuration(1.0)){
            self.noAdSprite.hidden = true
            self.musicSprite.hidden = true
            self.soundSprite.hidden = true
            self.coloredSprite.hidden = true
        }
        UIView.animateWithDuration(1.0, animations: {
            
            self.redSlider.alpha = 0
            self.greenSlider.alpha = 0
            self.blueSlider.alpha = 0
            
            }, completion: {(finished: Bool) -> Void in
                //Load new Stuff
        })
    }
    
    func achievementSecretMenu() {
        GC.reportAchievement(progress: 100.00, achievementIdentifier: "astronautica.achievement_secret", showBannnerIfCompleted: true, addToExisting: false)
    }
    
    func resetSecret() {
        secretUnlock.secretStep1 = false
        secretUnlock.secretStep2 = false
        secretUnlock.secretStep3 = false
        secretUnlock.secretStep4 = false
        secretUnlock.secretStep5 = false
        secretUnlock.secretStep6 = false
    }
    
    func showHeroColorMenu() {
        resetSecret()
        secretShown = true
        soundSprite.runAction(SKAction.fadeOutWithDuration(1.0))
        musicSprite.runAction(SKAction.fadeOutWithDuration(1.0))
        noAdSprite.runAction(SKAction.fadeOutWithDuration(1.0)){
            self.noAdSprite.hidden = true
            self.musicSprite.hidden = true
            self.soundSprite.hidden = true
            
            self.view?.addSubview(self.redSlider)
            self.view?.addSubview(self.greenSlider)
            self.view?.addSubview(self.blueSlider)
            self.coloredSprite.hidden = false
            self.coloredSprite.runAction(SKAction.fadeInWithDuration(1.0))
            
            UIView.animateWithDuration(1.0, animations: {
                self.redSlider.alpha = 1.0
                self.greenSlider.alpha = 1.0
                self.blueSlider.alpha = 1.0
            })
        }
    }
    
    func showSoundMenu() {
        
        coloredSprite.runAction(SKAction.fadeOutWithDuration(1.0)){
            self.coloredSprite.hidden = true
            
            self.redSlider.removeFromSuperview()
            self.greenSlider.removeFromSuperview()
            self.blueSlider.removeFromSuperview()
            
            self.musicSprite.hidden = false
            self.musicSprite.runAction(SKAction.fadeInWithDuration(1.0))
            self.soundSprite.hidden = false
            self.soundSprite.runAction(SKAction.fadeInWithDuration(1.0))
            self.noAdSprite.hidden = false
            self.noAdSprite.runAction(SKAction.fadeInWithDuration(1.0))
        }
        UIView.animateWithDuration(1.0, animations: {
            
            self.redSlider.alpha = 0
            self.greenSlider.alpha = 0
            self.blueSlider.alpha = 0
        })
    }
    
    func removeButtonAnim() {
    
        if lastSpriteName == self.backSprite.name  {
            backSprite.removeAllActions()
            backSprite.runAction(buttonPressLight)
        } else if lastSpriteName == self.menuColorSprite.name {
            menuColorSprite.removeAllActions()
            menuColorSprite.runAction(buttonPressLight)
        } else if lastSpriteName == menuThemeSprite.name {
            menuThemeSprite.removeAllActions()
            menuThemeSprite.runAction(buttonPressLight)
        } else if lastSpriteName == menuSoundSprite.name {
            menuSoundSprite.removeAllActions()
            menuSoundSprite.runAction(buttonPressLight)
        } else if lastSpriteName == noAdSprite.name {
            noAdSprite.removeAllActions()
            noAdSprite.runAction(buttonPressLight)
        } else if lastSpriteName == soundSprite.name {
            soundSprite.removeAllActions()
            soundSprite.runAction(buttonPressLight)
        } else if lastSpriteName == musicSprite.name {
            musicSprite.removeAllActions()
            musicSprite.runAction(buttonPressLight)
        }
    }
    
    func hideAds() {
        if interScene.adState == true {
            resetSecret()
            NSNotificationCenter.defaultCenter().postNotificationName("displayAdAlert", object: nil)
        }
    }
    
    func hideAdsSuccess() {
        interScene.adState = false
        interScene.smallAdLoad = false
        NSNotificationCenter.defaultCenter().postNotificationName("hideadsID", object: nil)
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "Ads")
        NSUserDefaults.standardUserDefaults().synchronize()
        adButtonSwitch()
    }
    
    func soundManagment() {
        if secretUnlock.secretStep2 == true && secretUnlock.secretStep4 == true{
            secretUnlock.secretStep5 = true
        } else if secretUnlock.secretStep2 == true {
            secretUnlock.secretStep3 = true
        } else {
            resetSecret()
        }
        
        if soundOn == true {
            soundOn = false
            soundSprite.texture = SKTexture(imageNamed: "SoundOffButton32")
        } else {
            soundOn = true
            soundSprite.texture = SKTexture(imageNamed: "SoundOnButton32")
        }
        interScene.soundState = soundOn
        NSUserDefaults.standardUserDefaults().setBool(soundOn, forKey: "soundBool")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func musicManagement() {
        if secretUnlock.secretStep1 == true && secretUnlock.secretStep3 == true {
            secretUnlock.secretStep4 = true
        } else if secretUnlock.secretStep1 == true {
            secretUnlock.secretStep2 = true
        } else {
            resetSecret()
        }
        
        if musicOn == true {
            musicOn = false
            musicSprite.texture = SKTexture(imageNamed: "MusicOffButton32")
            interScene.backgroundMusicP.stop()
            NSNotificationCenter.defaultCenter().postNotificationName("MusicOff", object: nil)
        } else {
            musicOn = true
            musicSprite.texture = SKTexture(imageNamed: "MusicOnButton32")
            interScene.backgroundMusicP.play()
            NSNotificationCenter.defaultCenter().postNotificationName("MusicOn", object: nil)
        }
        interScene.musicState = musicOn
        NSUserDefaults.standardUserDefaults().setBool(musicOn, forKey: "musicBool")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func screenInteractionStarted(location: CGPoint) {
        if self.nodeAtPoint(location) == self.backSprite {
            lastSpriteName = self.backSprite.name!
            self.backSprite.runAction(buttonPressDark)
        } else if self.nodeAtPoint(location) == self.menuColorSprite {
            lastSpriteName = self.menuColorSprite.name!
            self.menuColorSprite.runAction(buttonPressDark)
        } else if self.nodeAtPoint(location) == self.menuSoundSprite {
            lastSpriteName = self.menuSoundSprite.name!
            self.menuSoundSprite.runAction(buttonPressDark)
        } else if self.nodeAtPoint(location) == self.menuThemeSprite {
            lastSpriteName = self.menuThemeSprite.name!
            self.menuThemeSprite.runAction(buttonPressDark)
        } else if self.nodeAtPoint(location) == self.noAdSprite {
            if interScene.adState == true {
                lastSpriteName = self.noAdSprite.name!
                self.noAdSprite.runAction(buttonPressDark)
            }
        } else if self.nodeAtPoint(location) == self.soundSprite {
            lastSpriteName = self.soundSprite.name!
            self.soundSprite.runAction(buttonPressDark)
        } else if self.nodeAtPoint(location) == self.musicSprite {
            lastSpriteName = self.musicSprite.name!
            self.musicSprite.runAction(buttonPressDark)
        }
    }
    
    override func screenInteractionEnded(location: CGPoint) {
        if self.nodeAtPoint(location) == self.backSprite {
            removeButtonAnim()
            if lastSpriteName == self.backSprite.name {
                self.backSprite.runAction(buttonPressLight){
                    self.showMenu()
                }
            }
        } else if self.nodeAtPoint(location) == self.menuColorSprite {
            removeButtonAnim()
            if lastSpriteName == self.menuColorSprite.name {
                self.menuColorSprite.runAction(buttonPressLight){
                    self.showHeroColorMenu()
                }
            }
        } else if self.nodeAtPoint(location) == self.menuThemeSprite {
            removeButtonAnim()
            if lastSpriteName == self.menuThemeSprite.name {
                self.menuThemeSprite.runAction(buttonPressLight) {
                    self.showThemeMenu()
                }
            }
        } else if self.nodeAtPoint(location) == self.menuSoundSprite {
            removeButtonAnim()
            if lastSpriteName == self.menuSoundSprite.name {
                self.menuSoundSprite.runAction(buttonPressLight) {
                    self.showSoundMenu()
                }
            }
        } else if self.nodeAtPoint(location) == self.noAdSprite {
            removeButtonAnim()
            if lastSpriteName == self.noAdSprite.name {
                if interScene.adState == true {
                    self.noAdSprite.runAction(buttonPressLight){
                        self.hideAds()
                    }
                }
            }
        } else if self.nodeAtPoint(location) == self.soundSprite {
            removeButtonAnim()
            if lastSpriteName == self.soundSprite.name {
                self.soundSprite.runAction(buttonPressLight){
                    self.soundManagment()
                }
            }
        } else if self.nodeAtPoint(location) == self.musicSprite {
            removeButtonAnim()
            if lastSpriteName == self.musicSprite.name {
                self.musicSprite.runAction(buttonPressLight){
                    self.musicManagement()
                }
            }
        } else {
            resetSecret()
            backSprite.removeAllActions()
            menuColorSprite.removeAllActions()
            menuThemeSprite.removeAllActions()
            menuSoundSprite.removeAllActions()
            noAdSprite.removeAllActions()
            musicSprite.removeAllActions()
            soundSprite.removeAllActions()
            self.backSprite.runAction(buttonPressLight)
            self.menuColorSprite.runAction(buttonPressLight)
            self.menuThemeSprite.runAction(buttonPressLight)
            self.menuSoundSprite.runAction(buttonPressLight)
            if interScene.adState == true {
                self.noAdSprite.runAction(buttonPressLight)
            }
            self.musicSprite.runAction(buttonPressLight)
            self.soundSprite.runAction(buttonPressLight)
        }
    }
    
    func showMenu() {
        
        optionSceneActive = false
        
        UIView.animateWithDuration(1.0, animations: {
        
            self.redSlider.alpha = 0
            self.greenSlider.alpha = 0
            self.blueSlider.alpha = 0
            
        }, completion: {(finished: Bool) -> Void in
        
            self.redSlider.removeFromSuperview()
            self.greenSlider.removeFromSuperview()
            self.blueSlider.removeFromSuperview()
            
        })
        
        if secretShown == true {
            
            showSoundMenu()
            secretShown = false
            
        } else {
        
            let transition = SKTransition.fadeWithDuration(1)
            let scene = GameScene(size: self.size)
            let skView = self.view as SKView!
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .ResizeFill
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            scene.size = skView.bounds.size
            skView.presentScene(scene, transition: transition)
            
        }
    }
    
    func loadSoundState() {
        if interScene.musicState == true {
            NSNotificationCenter.defaultCenter().postNotificationName("MusicOn", object: nil)
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName("MusicOff", object: nil)
        }
    }
    
    func sliderValueDidChange() {
        if optionSceneActive {

            red = Float(redSlider.value)
            green = Float(greenSlider.value)
            blue = Float(blueSlider.value)
            let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
            
            heroColor.heroColorRed = red
            heroColor.heroColorGreen = green
            heroColor.heroColorBlue = blue
            
            NSUserDefaults.standardUserDefaults().setFloat(red, forKey: "heroColorRed")
            NSUserDefaults.standardUserDefaults().setFloat(green, forKey: "heroColorGreen")
            NSUserDefaults.standardUserDefaults().setFloat(blue, forKey: "heroColorBlue")
            NSUserDefaults.standardUserDefaults().synchronize()
        
            coloredSprite.color = color
            coloredSprite.colorBlendFactor = 0.4
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
            /* Called before each frame is rendered */
        updateBGPosition()
    }

}