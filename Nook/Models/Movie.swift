//
//  Movie.swift
//  Nook
//
//  Created by Risini Senara on 2026-10-16.
//


import Foundation

struct Movie: Identifiable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let mood: String
    let description: String
    let artworkName: String
    let isPlayable: Bool

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        mood: String,
        description: String,
        artworkName: String,
        isPlayable: Bool = false
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.mood = mood
        self.description = description
        self.artworkName = artworkName
        self.isPlayable = isPlayable
    }
}

