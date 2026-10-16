//
//  QuestionBank.swift
//  MindQuest
//
//  Created by Risini Senara on 2026-10-15.
//


import Foundation

enum QuestionBank {

    static let questions: [QuizQuestion] = [

        // MARK: - Space

        QuizQuestion(
            category: .space,
            question: "Which planet is known as the Red Planet?",
            answers: ["Venus", "Mars", "Jupiter", "Mercury"],
            correctAnswer: 1,
            explanation: "Iron-rich dust gives Mars its reddish appearance."
        ),
        QuizQuestion(
            category: .space,
            question: "Which star is closest to Earth?",
            answers: ["Sirius", "Polaris", "The Sun", "Vega"],
            correctAnswer: 2,
            explanation: "The Sun is our nearest star."
        ),
        QuizQuestion(
            category: .space,
            question: "Which planet has the most prominent rings?",
            answers: ["Earth", "Saturn", "Neptune", "Mars"],
            correctAnswer: 1,
            explanation: "Saturn's spectacular rings consist mainly of ice and rock."
        ),
        QuizQuestion(
            category: .space,
            question: "What is the name of our galaxy?",
            answers: ["Andromeda", "Whirlpool", "Milky Way", "Sombrero"],
            correctAnswer: 2,
            explanation: "Our solar system is part of the Milky Way galaxy."
        ),
        QuizQuestion(
            category: .space,
            question: "What force keeps planets in orbit around the Sun?",
            answers: ["Magnetism", "Gravity", "Friction", "Electricity"],
            correctAnswer: 1,
            explanation: "Gravity holds planets in their orbits around the Sun."
        ),

        // MARK: - Science

        QuizQuestion(
            category: .science,
            question: "What is the chemical symbol for gold?",
            answers: ["Go", "Gd", "Au", "Ag"],
            correctAnswer: 2,
            explanation: "Au comes from the Latin word aurum."
        ),
        QuizQuestion(
            category: .science,
            question: "Which organ pumps blood around the body?",
            answers: ["Lungs", "Brain", "Liver", "Heart"],
            correctAnswer: 3,
            explanation: "The heart circulates blood throughout your body."
        ),
        QuizQuestion(
            category: .science,
            question: "What is the approximate speed of light in a vacuum?",
            answers: [
                "300 km/s",
                "3,000 km/s",
                "300,000 km/s",
                "30 million km/s"
            ],
            correctAnswer: 2,
            explanation: "Light travels at approximately 300,000 kilometres per second."
        ),
        QuizQuestion(
            category: .science,
            question: "Which gas do plants absorb during photosynthesis?",
            answers: ["Oxygen", "Carbon dioxide", "Hydrogen", "Helium"],
            correctAnswer: 1,
            explanation: "Plants use carbon dioxide, water and light to make sugars."
        ),
        QuizQuestion(
            category: .science,
            question: "What is the centre of an atom called?",
            answers: ["Electron", "Shell", "Nucleus", "Molecule"],
            correctAnswer: 2,
            explanation: "The nucleus contains protons and usually neutrons."
        ),

        // MARK: - Nature

        QuizQuestion(
            category: .nature,
            question: "What is the largest animal on Earth?",
            answers: ["African elephant", "Blue whale", "Giraffe", "Orca"],
            correctAnswer: 1,
            explanation: "The blue whale is the largest known animal."
        ),
        QuizQuestion(
            category: .nature,
            question: "Which part of a plant absorbs most water?",
            answers: ["Flowers", "Leaves", "Roots", "Fruit"],
            correctAnswer: 2,
            explanation: "Roots absorb water and minerals from the soil."
        ),
        QuizQuestion(
            category: .nature,
            question: "What is a baby frog called?",
            answers: ["Cub", "Tadpole", "Calf", "Chick"],
            correctAnswer: 1,
            explanation: "Frogs begin life as aquatic tadpoles."
        ),
        QuizQuestion(
            category: .nature,
            question: "Which is the fastest land animal?",
            answers: ["Lion", "Horse", "Cheetah", "Leopard"],
            correctAnswer: 2,
            explanation: "Cheetahs can reach very high speeds over short distances."
        ),
        QuizQuestion(
            category: .nature,
            question: "What do bees collect from flowers to make honey?",
            answers: ["Nectar", "Tree bark", "Dew", "Seeds"],
            correctAnswer: 0,
            explanation: "Bees collect nectar and transform it into honey."
        ),

        // MARK: - History

        QuizQuestion(
            category: .history,
            question: "Which ancient civilisation built the pyramids at Giza?",
            answers: ["Romans", "Egyptians", "Vikings", "Persians"],
            correctAnswer: 1,
            explanation: "The pyramids were built in ancient Egypt."
        ),
        QuizQuestion(
            category: .history,
            question: "What was the ancient Roman language?",
            answers: ["Greek", "Arabic", "Latin", "French"],
            correctAnswer: 2,
            explanation: "Latin was the language of ancient Rome."
        ),
        QuizQuestion(
            category: .history,
            question: "Which city was buried by Mount Vesuvius in AD 79?",
            answers: ["Athens", "Pompeii", "Sparta", "Carthage"],
            correctAnswer: 1,
            explanation: "The eruption buried Pompeii under volcanic material."
        ),
        QuizQuestion(
            category: .history,
            question: "The Great Wall is located in which country?",
            answers: ["India", "Japan", "China", "Thailand"],
            correctAnswer: 2,
            explanation: "The Great Wall is a historic fortification in China."
        ),
        QuizQuestion(
            category: .history,
            question: "Which invention is Johannes Gutenberg famous for?",
            answers: [
                "Steam engine",
                "Printing press",
                "Telephone",
                "Compass"
            ],
            correctAnswer: 1,
            explanation: "Gutenberg helped develop European movable-type printing."
        )
    ]
}
