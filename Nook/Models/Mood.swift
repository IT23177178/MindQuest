//
//  Mood.swift
//  Nook
//
//  Created by Risini Senara on 2026-10-16.
//


import Foundation

struct Mood: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let symbol: String

    init(
        title: String,
        subtitle: String,
        symbol: String
    ) {
        self.id = title
        self.title = title
        self.subtitle = subtitle
        self.symbol = symbol
    }

    static let featured: [Mood] = [
        Mood(
            title: "Rainy Day",
            subtitle: "Cosy stories for slow days",
            symbol: "cloud.rain"
        ),
        Mood(
            title: "Fantasy",
            subtitle: "Step into another world",
            symbol: "sparkles"
        ),
        Mood(
            title: "Nature",
            subtitle: "Discover the world around you",
            symbol: "leaf"
        ),
        Mood(
            title: "Wind Down",
            subtitle: "Something gentle before bed",
            symbol: "moon.stars"
        )
    ]
}
