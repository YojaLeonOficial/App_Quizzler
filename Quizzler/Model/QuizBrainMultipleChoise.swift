//
//  QuizBrainMultipleChoise.swift
//  Quizzler
//
//  Created by Yojairo Jose Leon Escobar on 6/12/22.
//

import Foundation

struct QuizBrainMultipleChoise {
    
    var questionNumber = 0
    var rightAnswer = 0
    var wrongAnswer = 0
    
    let quizMultipleChoise = [
        QuestionMultipleChoise(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        QuestionMultipleChoise(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        QuestionMultipleChoise(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        QuestionMultipleChoise(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        QuestionMultipleChoise(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        QuestionMultipleChoise(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        QuestionMultipleChoise(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        QuestionMultipleChoise(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        QuestionMultipleChoise(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        QuestionMultipleChoise(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]
    
    mutating func checkAnswer(userAnswer: String) -> Bool {
        //Need to change answer to rightAnswer here.
        if userAnswer == quizMultipleChoise[questionNumber].rightAnswer {
            rightAnswer += 1
            return true
        } else {
            wrongAnswer += 1
            return false
        }
    }
    
    func getQuestionText() -> String {
        return quizMultipleChoise[questionNumber].text
    }
    
    func getProgressBar() -> Float {
        return Float(questionNumber + 1) / Float(quizMultipleChoise.count)
    }
    
    mutating func nextQuestion() {
       
       if questionNumber + 1 < quizMultipleChoise.count {
           questionNumber += 1
       } else {
           questionNumber = 0
       }
   }
   
    func getAnswers() -> [String] {
        return quizMultipleChoise[questionNumber].answers
    }
    
    func hiddenHS() -> Bool {
        if questionNumber < 1 {
            return true
        } else {
            return false
        }
    }
    
    func hiddenRightLabel() -> Bool {
        if rightAnswer < 1 {
            return true
        } else {
            return false
        }
    }
    
    func hiddenWrongLabel() -> Bool {
        if wrongAnswer < 1 {
            return true
        } else {
            return false
        }
    }
}
