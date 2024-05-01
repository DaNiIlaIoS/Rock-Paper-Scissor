//
//  ViewController.swift
//  RPS
//
//  Created by Zhangali Pernebayev on 30.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rpsImageOne: UIImageView!
    @IBOutlet weak var rpsImageTwo: UIImageView!
    @IBOutlet weak var vsImage: UIImageView!
    @IBOutlet weak var rpsLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var myScoreLabel: UILabel!
    @IBOutlet weak var computerScoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var myScore: Int = 0
    var computerScore: Int = 0
    
    let images = [
        UIImage(named: "paper"),
        UIImage(named: "rock"),
        UIImage(named: "scissors")
    ]
    
    var timer: Timer?
    var countDown: Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Устанавливаем картинки
        rpsImageOne.image = UIImage(named: "paper")
        rpsImageTwo.image = UIImage(named: "paper")
        vsImage.image = UIImage(named: "versus-1")
        
        // Текст Label
        rpsLabel.text = "Rock-Paper-Scissors"
        
        // Настраиваем кнопку
        playButton.backgroundColor = UIColor.black
        
        updateScores()
        
        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scheduleTimer()
    }
    
    
    @IBAction func playButtonTapped(_ sender: Any) {
        let myIndex = randomImageIndex()
        let computerIndex = randomImageIndex()
        print("Button was tapped")
        rpsImageOne.image = images[myIndex]
        rpsImageTwo.image = images[computerIndex]
        let result = setWinner(myIndex, computerIndex)
        
        if result == "computerWins" {
            computerScore += 1
        } else if result == "playrWins" {
            myScore += 1
        }
        updateScores()
    }
    
    func randomImageIndex() -> Int {
        return Int.random(in: 0..<images.count)
    }
    
    func updateScores() {
        myScoreLabel.text = String(myScore)
        computerScoreLabel.text = String(computerScore)
    }
    func setWinner(_ computerIndex: Int, _ myIndex: Int) -> String {
        if computerIndex == myIndex {
            return "draw"
        } else if (myIndex + 1) % images.count == computerIndex {
            return "computerWins"
        } else {
            return "playrWins"
        }
    }
    
    func scheduleTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerUI), userInfo: nil, repeats: true)
    }
    
    @objc
    func updateTimerUI() {
        countDown -= 1
        
        timerLabel.text = "00 : \(countDown)"
        progressView.progress = Float(30 - countDown) / 30
        print("progressView.progress: \(progressView.progress)")
        
        if countDown <= 0 {
            timer?.invalidate()
            printWinner()
        }
    }
    
    func printWinner() {
        if myScore > computerScore {
            let alertController = UIAlertController(title: " Game over", message: "I won", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              self.present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: " Game over", message: "Computer won", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              self.present(alertController, animated: true)
        }
    }
    
}

