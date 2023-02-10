//
//  ViewController.swift
//  Quizzler
//
//  Created by Yojairo Jose Leon Escobar on 25/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var ProgressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var counterRWStack: UIStackView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var ChoiseThree: UIButton!
    
    var quizBrainMultipleChoise = QuizBrainMultipleChoise()
    var quizBrain = QuizBrain()
    var timer = Timer()
    var seconds = 4
    var highScore = 0
    var gameA = ""
    var gameB = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreen()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        print(sender.currentTitle!)
        timer.invalidate()
        gameReset()
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sender.alpha = 1.0
            self.startButton.isHidden = true
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startQuestion), userInfo: nil, repeats: true)
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        
        let selectedOption = sender.currentTitle!
        let userGotItRightTF =  quizBrain.checkAnswer(selectedOption)
        let userGotItRightMC = quizBrainMultipleChoise.checkAnswer(userAnswer: selectedOption)
        
        if selectedOption == "True / Flase Choise" {
            gameA = "ON"
            gameB = "OFF"
            startButton.isHidden = false
            questionLabel.text = "Are you ready for this?"
            trueButton.isHidden = true
            falseButton.isHidden = true
            ChoiseThree.isHidden = true
            trueButton.setTitle("True", for: .normal)
            falseButton.setTitle("Flase", for: .normal)
            scoreLabel.text = "Score: \(quizBrain.rightAnswer) of \(quizBrain.quizArray.count)"
            
        } else if selectedOption == "Multiple Choise" {
            gameA = "OFF"
            gameB = "ON"
            startButton.isHidden = false
            questionLabel.text = "Are you ready for this?"
            trueButton.isHidden = true
            falseButton.isHidden = true
            ChoiseThree.isHidden = true
            let answerChoices = quizBrainMultipleChoise.getAnswers()
            trueButton.setTitle(answerChoices[0], for: .normal)
            falseButton.setTitle(answerChoices[1], for: .normal)
            ChoiseThree.setTitle(answerChoices[2], for: .normal)
            scoreLabel.text = "Score: \(quizBrainMultipleChoise.rightAnswer) of \(quizBrainMultipleChoise.quizMultipleChoise.count)"
            
        } else if gameA == "ON" {
            if userGotItRightTF {
                sender.backgroundColor = UIColor.green
                highScore += 1
                print(highScore)
            } else {
                sender.backgroundColor = UIColor.red
                highScore = 0
            }
            quizBrain.nextQuestion()
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
            ProgressBar.progress = quizBrain.getProgressBar()
            if quizBrain.hiddenHS() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.showAlert(message: "Another Round?")
                }
            }
            
        } else if gameB == "ON"{
            if userGotItRightMC {
                sender.backgroundColor = UIColor.green
                highScore += 1
                print(highScore)
            } else {
                sender.backgroundColor = UIColor.red
                highScore = 0
            }
            quizBrainMultipleChoise.nextQuestion()
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
            ProgressBar.progress = quizBrainMultipleChoise.getProgressBar()
            if quizBrainMultipleChoise.hiddenHS() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.showAlert(message: "Another Round?")
                }
            }
        }
    }
    
    @objc func updateUI() {
        
        if gameA == "ON" {
            self.timer.invalidate()
            questionLabel.text = quizBrain.getQuestionText()
            self.trueButton.backgroundColor = UIColor.clear
            self.falseButton.backgroundColor = UIColor.clear
            rightLabel.text = "Right = \(quizBrain.rightAnswer)"
            wrongLabel.text = "Wrong = \(quizBrain.wrongAnswer)"
            ProgressBar.progress = quizBrain.getProgressBar()
            rightLabel.isHidden = quizBrain.hiddenRightLabel()
            wrongLabel.isHidden = quizBrain.hiddenWrongLabel()
            counterRWStack.isHidden = quizBrain.hiddenHS()
            scoreLabel.text = "Score: \(quizBrain.rightAnswer) of \(quizBrain.quizArray.count)"
            scoreLabelMessage(highScore)
            resultScreen()
            
        } else if gameB == "ON"{
            self.timer.invalidate()
            questionLabel.text = quizBrainMultipleChoise.getQuestionText()
            rightLabel.text = "Right = \(quizBrainMultipleChoise.rightAnswer)"
            wrongLabel.text = "Wrong = \(quizBrainMultipleChoise.wrongAnswer)"
            rightLabel.isHidden = quizBrainMultipleChoise.hiddenRightLabel()
            wrongLabel.isHidden = quizBrainMultipleChoise.hiddenWrongLabel()
            counterRWStack.isHidden = quizBrainMultipleChoise.hiddenHS()
            ProgressBar.progress = quizBrainMultipleChoise.getProgressBar()
            let answerChoices = quizBrainMultipleChoise.getAnswers()
            trueButton.setTitle(answerChoices[0], for: .normal)
            falseButton.setTitle(answerChoices[1], for: .normal)
            ChoiseThree.setTitle(answerChoices[2], for: .normal)
            trueButton.backgroundColor = UIColor.clear
            falseButton.backgroundColor = UIColor.clear
            ChoiseThree.backgroundColor = UIColor.clear
            scoreLabelMessage(highScore)
            scoreLabel.text = "Score: \(quizBrainMultipleChoise.rightAnswer) of \(quizBrainMultipleChoise.quizMultipleChoise.count)"
            scoreLabelMessage(highScore)
            resultScreen()
        }
    }
    
    @objc func startQuestion() {
        seconds -= 1
        questionLabel.text = "\(seconds)"
        if seconds == 0 {
            timer.invalidate()
            scoreLabel.isHidden = true
            questionLabel.text = "Goooo!!!"
            
            
            if gameA == "ON" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.trueButton.setTitle("True", for: .normal)
                    self.falseButton.setTitle("False", for: .normal)
                    self.questionLabel.text = self.quizBrain.getQuestionText()
                    self.trueButton.isHidden = false
                    self.falseButton.isHidden = false
                    self.ChoiseThree.isHidden = true
                    self.ProgressBar.isHidden = false
                    self.ProgressBar.progress = self.quizBrain.getProgressBar()
                    self.scoreLabel.text = "Score: \(self.quizBrain.rightAnswer) of \(self.quizBrain.quizArray.count)"
                    self.scoreLabel.isHidden = false
                }
            } else if gameB == "ON"{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.questionLabel.text = self.quizBrainMultipleChoise.getQuestionText()
                    let answerChoices = self.quizBrainMultipleChoise.getAnswers()
                    self.trueButton.setTitle(answerChoices[0], for: .normal)
                    self.falseButton.setTitle(answerChoices[1], for: .normal)
                    self.ChoiseThree.setTitle(answerChoices[2], for: .normal)
                    self.trueButton.isHidden = false
                    self.falseButton.isHidden = false
                    self.ChoiseThree.isHidden = false
                    self.ProgressBar.isHidden = false
                    self.ProgressBar.progress = self.quizBrainMultipleChoise.getProgressBar()
                    self.scoreLabel.text = "Score: \(self.quizBrainMultipleChoise.rightAnswer) of \(self.quizBrainMultipleChoise.quizMultipleChoise.count)"
                    self.scoreLabel.isHidden = false
                    
                }
            }
        }
    }
    
    private func resultScreen() {
        
        if gameA == "ON" && quizBrain.hiddenHS() {
            questionLabel.text = "You got \n \(quizBrain.rightAnswer) answer Right \n and \(quizBrain.wrongAnswer) wrong \n \n \n"
            hiddenStuff()
        } else if gameB == "ON" && quizBrainMultipleChoise.hiddenHS() {
            questionLabel.text = "You got \n \(quizBrainMultipleChoise.rightAnswer) answer Right \n and \(quizBrainMultipleChoise.wrongAnswer) wrong \n \n"
            hiddenStuff()
        }
    }
    
    private func hiddenStuff() {
        trueButton.isHidden = true
        falseButton.isHidden = true
        ChoiseThree.isHidden = true
        ProgressBar.isHidden = true
    }
    
    private func scorelabelStyle() {
        if highScore == 3 ||
            highScore == 6 ||
            highScore == quizBrain.quizArray.count && gameA == "ON" ||
            quizBrainMultipleChoise.quizMultipleChoise.count == highScore && gameB == "ON" {
            scoreLabel.textAlignment = .center
            scoreLabel.textColor = UIColor.red
            scoreLabel.font = UIFont.systemFont(ofSize: 25)
        } else {
            scoreLabel.textAlignment = .left
            scoreLabel.textColor = UIColor.white
            scoreLabel.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    private func scoreLabelMessage(_ highScore: Int){
        scorelabelStyle()
        if highScore == 3 {
            scoreLabel.text = "Three in line, You are OnFire!!! \n🔥🔥🔥 \n keep goin´"
        } else if highScore == 6 {
            scoreLabel.text = "Six in line, You are killin´ it!!! \n🤓😎🤓 \n You almost get it"
        } else if quizBrain.quizArray.count == highScore && gameA == "ON" || quizBrainMultipleChoise.quizMultipleChoise.count == highScore && gameB == "ON" {
            scoreLabel.text = "O.M.G. perfect Score \n🎊🎉 You are the best 🎉🎊"
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "QUIZZLER", message: message, preferredStyle: .alert)
        
        if gameA == "ON" || gameB == "ON"{
            let submitButtonA = UIAlertAction(title: "Start Over", style: .default) { (action) in
                self.homeScreen()
                self.gameReset()
            }
            let submitButtonB = UIAlertAction(title: "No this time", style: .default) { (action) in
                self.gameReset()
                self.questionLabel.text = "See You Next time"
                self.scoreLabel.isHidden = true
            }
            
            // Add button
            alert.addAction(submitButtonA)
            alert.addAction(submitButtonB)
            
            //show Alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func homeScreen () {
        updateUI()
        questionLabel.text = "Hello \n Quizzler!! \n Which game do you wanna try??"
        trueButton.layer.cornerRadius = 20
        falseButton.layer.cornerRadius = 20
        ChoiseThree.layer.cornerRadius = 20
        trueButton.setTitle("Multiple Choise", for: .normal)
        falseButton.setTitle("True / Flase Choise", for: .normal)
        trueButton.isHidden = false
        falseButton.isHidden = false
        ProgressBar.isHidden = true
        scoreLabel.isHidden = true
        startButton.isHidden = true
        ChoiseThree.isHidden = true
        counterRWStack.isHidden = true
        scorelabelStyle()
    }
    
    private func gameReset() {
        timer.invalidate()
        seconds = 4
        highScore = 0
        quizBrain.rightAnswer = 0
        quizBrain.wrongAnswer = 0
        quizBrainMultipleChoise.rightAnswer = 0
        quizBrainMultipleChoise.wrongAnswer = 0
        scoreLabel.text = "Score: \(quizBrain.rightAnswer) of \(quizBrain.quizArray.count)"
        scoreLabel.text = "Score: \(self.quizBrainMultipleChoise.rightAnswer) of \(self.quizBrainMultipleChoise.quizMultipleChoise.count)"
        scorelabelStyle()
        
    }
    
}

