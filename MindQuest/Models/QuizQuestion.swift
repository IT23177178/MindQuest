//
//  QuizQuestion.swift
//  MindQuest
//
//  Created by Risini Senara on 2026-10-15.
//



import Foundation

struct QuizQuestion: Identifiable {
    let id = UUID()
    let category: QuizCategory
    let question: String
    let answers: [String]
    let correctAnswer: Int
    let explanation: String
}


