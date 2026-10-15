//
//  QuizCategory.swift
//  MindQuest
//
//  Created by Risini Senara on 2026-10-15.
//


import SwiftUI

enum QuizCategory: String, CaseIterable, Identifiable {
    case space = "Space"
    case science = "Science"
    case nature = "Nature"
    case history = "History"

    var id: String {
        rawValue
    }

    var symbol: String {
        switch self {
        case .space:
            return "sparkles"
        case .science:
            return "atom"
        case .nature:
            return "leaf"
        case .history:
            return "globe.europe.africa"
        }
    }

    var subtitle: String {
        switch self {
        case .space:
            return "Beyond our world"
        case .science:
            return "Discover how it works"
        case .nature:
            return "Explore the wild"
        case .history:
            return "Journey through time"
        }
    }

    var color: Color {
        switch self {
        case .space:
            return Color(
                red: 0.53,
                green: 0.39,
                blue: 1.0
            )
        case .science:
            return Color(
                red: 0.27,
                green: 0.70,
                blue: 0.92
            )
        case .nature:
            return Color(
                red: 0.30,
                green: 0.75,
                blue: 0.57
            )
        case .history:
            return Color(
                red: 0.95,
                green: 0.63,
                blue: 0.35
            )
        }
    }
}
