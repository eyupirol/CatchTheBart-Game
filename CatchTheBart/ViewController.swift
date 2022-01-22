//
//  ViewController.swift
//  CatchTheBart
//
//  Created by Eyüp Ensar Pirol on 15.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
//variables
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var bartArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0

//views
    @IBOutlet weak var timeBoard: UILabel!
    @IBOutlet weak var scoreBoard: UILabel!
    @IBOutlet weak var higscoreBoard: UILabel!
    @IBOutlet weak var firstBart: UIImageView!
    @IBOutlet weak var secondBart: UIImageView!
    @IBOutlet weak var thirdBart: UIImageView!
    @IBOutlet weak var forthBart: UIImageView!
    @IBOutlet weak var fifthBart: UIImageView!
    @IBOutlet weak var sixthBart: UIImageView!
    @IBOutlet weak var seventhBart: UIImageView!
    @IBOutlet weak var eighthBart: UIImageView!
    @IBOutlet weak var ninethBart: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreBoard.text = "Score:\(score)"
        
//Highscore control
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil{
            highScore = 0
            higscoreBoard.text = "Highscore:\(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            higscoreBoard.text = "Highscore : \(highScore)"
        }
            
            
            
//Images setting
            
            
        firstBart.isUserInteractionEnabled = true
        secondBart.isUserInteractionEnabled = true
        thirdBart.isUserInteractionEnabled = true
        forthBart.isUserInteractionEnabled = true
        fifthBart.isUserInteractionEnabled = true
        sixthBart.isUserInteractionEnabled = true
        seventhBart.isUserInteractionEnabled = true
        eighthBart.isUserInteractionEnabled = true
        ninethBart.isUserInteractionEnabled = true

        
        let firstRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let secondRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let thirdRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let forthRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let fifthRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let sixthRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let seventhRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let eighthRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let ninethRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        firstBart.addGestureRecognizer(firstRecognizer)
        secondBart.addGestureRecognizer(secondRecognizer)
        thirdBart.addGestureRecognizer(thirdRecognizer)
        forthBart.addGestureRecognizer(forthRecognizer)
        fifthBart.addGestureRecognizer(fifthRecognizer)
        sixthBart.addGestureRecognizer(sixthRecognizer)
        seventhBart.addGestureRecognizer(seventhRecognizer)
        eighthBart.addGestureRecognizer(eighthRecognizer)
        ninethBart.addGestureRecognizer(ninethRecognizer)
        
        bartArray = [firstBart,secondBart,thirdBart,forthBart,fifthBart,sixthBart,seventhBart,eighthBart,ninethBart,]
        

// timers
        counter = 10
        timeBoard.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideBart), userInfo: nil, repeats: true)
        
        
        hideBart()
        
        
        
    }
    
    @objc func hideBart(){
        
        for bart in bartArray{
            bart.isHidden = true
        }
        let random =  Int(arc4random_uniform (UInt32(bartArray.count-1)))
        bartArray[random].isHidden = false
    }

    @objc func increaseScore(){
        score += 1
        scoreBoard.text = "Score:\(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeBoard.text = String ( counter)
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            for bart in bartArray{
                bart.isHidden = true
            }
//highScore
            if self.score > self.highScore{
                self.highScore = self.score
                higscoreBoard.text = "Highcore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
                
            
            
            
// alert / time is up!
            
            let alert = UIAlertController(title: "Time's up!", message: "Let's play again!", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Exit", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay!", style: UIAlertAction.Style.default) { [self] (UIAlertAction) in
//replay function
             
                self.score = 0
                self.scoreBoard.text = "Score : \(self.score)"
                self.counter = 10
                self.timeBoard.text = String(self.counter)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideBart), userInfo: nil, repeats: true)
                
                
                
                
                
            }
             
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

