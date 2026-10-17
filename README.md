# Nook — A Little Escape

A cinematic streaming discovery experience designed for Apple TV, helping children aged 7–10 discover short films through a calm, engaging, and accessible interface.

## 1. Project Overview

Nook is a tvOS application prototype developed as part of the SE4041 Mobile Application Design and Development module.

The application is designed for children aged 7–10. It presents a curated collection of films in a visually engaging interface, allowing young viewers to explore stories based on mood and discover content in a simple, comfortable environment.

The prototype includes a featured film, film detail pages, curated recommendations, and video playback for the short film *Snow Bear*.

**Tagline:** A little escape.

## 2. Project Objectives

- Design a child-friendly film discovery experience for Apple TV.
- Create a cinematic interface that makes browsing enjoyable and straightforward.
- Organise film selections by mood to support discovery.
- Provide film information and related recommendations before playback.
- Demonstrate native tvOS interface design and video playback using SwiftUI and AVKit.

## 3. Target Audience

Nook is designed primarily for children aged 7–10 who want to discover and watch short films.

The interface uses clear visual hierarchy, large artwork, readable text, and prominent controls to support comfortable viewing on a television screen.

## 4. Core Features

### Cinematic Home Screen

The home screen introduces Nook through a featured film area, branded messaging, and horizontally arranged film collections.

### Mood-Based Discovery

Films are organised into mood-based collections, helping users explore content according to the experience they want.

### Film Details

Each film has a dedicated detail screen displaying its artwork, title, metadata, description, synopsis, creator information where available, running time, and recommendations.

### Video Playback

The prototype includes playable video content for *Snow Bear*, allowing users to launch the film from its detail screen.

### Curated Recommendations

Related films are presented on the detail screen to encourage further discovery.

## 5. Technology Stack

- **Platform:** Apple tvOS
- **Programming Language:** Swift
- **User Interface:** SwiftUI
- **Video Playback:** AVKit and AVFoundation
- **Development Environment:** Xcode
- **Version Control:** Git and GitHub

## 6. Application Structure

The repository contains the Nook project alongside an earlier MindQuest project.

```text
MindQuest/
├── Nook.xcodeproj/
├── Nook/
│   ├── HomeViewModel.swift
│   ├── VideoPlayerService.swift
│   ├── SnowBear.mp4
│   └── [Other application source files and assets]
├── MindQuest.xcodeproj/
├── MindQuest/
└── README.md
```

*Note: The file list above illustrates the main project organisation. Refer to the actual Nook folder for the complete set of source files and assets.*

## 7. Running the Application

### Requirements

- A Mac with Xcode installed.
- The Nook Xcode project and its associated assets.

### Instructions

1. Clone or download this repository.
2. Open `Nook.xcodeproj` in Xcode.
3. Select an available Apple TV simulator compatible with the project.
4. Select the Nook app scheme.
5. Build and run the application.

The playable film and artwork assets must remain available to the project for the corresponding features to work.

## 8. Prototype Scope and Limitations

Nook is a prototype demonstrating the main browsing, film information, recommendation, and playback experience.

The current implementation includes one playable short film, *Snow Bear*. Other displayed films form part of the discovery interface and should not be assumed to have working playback.

The prototype does not represent a complete commercial streaming service. Features such as user accounts, parental controls, remote content management, and a production streaming catalogue are outside the current scope.

## 9. Future Improvements

Potential improvements include:

- Expanding the collection of playable short films.
- Adding parental controls and age-appropriate content management.
- Improving content organisation and recommendation capabilities.
- Conducting usability testing with the intended audience and their guardians.
- Optimising navigation and accessibility for the Apple TV remote.

## 10. Academic Declaration

This project was developed for academic purposes as part of the SE4041 Mobile Application Design and Development module.

AI assistance was used during development for guidance, code troubleshooting, design refinement, and documentation support. The submitted implementation should be reviewed and understood by the student, and AI assistance should be declared in accordance with the module's assessment requirements.

## 11. Project Information

- **Project:** Nook
- **Platform:** tvOS (Apple TV)
- **Module:** SE4041 — Mobile Application Design and Development
- **Academic Year:** 2026
