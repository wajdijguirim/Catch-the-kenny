//
//  ViewController.swift
//  Catch the kenny
//
//  Created by PAUL on 09/02/2019.
//  Copyright © 2019 PAUL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var counter = 0
    var timer = Timer()
    var hideTimer = Timer()
    var score = 0
    var kennyarray = [UIImageView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //check the high score
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        if highScore == nil{
            highScoreLabel.text = "0"
        }
        if let newScore = highScore as? Int {
            highScoreLabel.text = String(newScore)
        }
        
        scoreLabel.text = "score \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        //creating timer
        counter = 30
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
        // creating array of images
        kennyarray.append(kenny1)
        kennyarray.append(kenny2)
        kennyarray.append(kenny3)
        kennyarray.append(kenny4)
        kennyarray.append(kenny5)
        kennyarray.append(kenny6)
        kennyarray.append(kenny7)
        kennyarray.append(kenny8)
        kennyarray.append(kenny9)
        
        hideKenny()
    }

    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    @objc func countDown(){
        counter = counter - 1
        timeLabel.text = "\(counter)"
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            //checking high score
            if self.score > Int(highScoreLabel.text!)!{
                UserDefaults.standard.set(self.score, forKey: "highScore")
                highScoreLabel.text = String(self.score)
            }
            
            //alert creation
            let alert = UIAlertController(title: "Alert", message: "Your time is up", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(ok)
            
            let replay = UIAlertAction(title: "replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
               
                
                
            }
            
            alert.addAction(replay)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func hideKenny(){
        for kenny in kennyarray{
            kenny.isHidden = true
        }
        let randomNumber = Int(arc4random_uniform(UInt32(kennyarray.count - 1)))
        kennyarray[randomNumber].isHidden = false
    }
}

