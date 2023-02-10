//
//  QuestionMultipleChoise.swift
//  Quizzler
//
//  Created by Yojairo Jose Leon Escobar on 6/12/22.
//

import Foundation

struct QuestionMultipleChoise {
    let text: String
    let answers: [String]
    let rightAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        text = q
        answers = a
        rightAnswer = correctAnswer
    }
    
}
