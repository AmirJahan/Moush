# Moush - SVG Editor for iOS

An iOS mobile application for browsing, editing, and sharing SVG artwork with cloud synchronization.

## Overview

Moush is a community-driven SVG editor and gallery that allows users to browse shared artwork, modify SVG properties, and upload their creations to the cloud.

## Features

### SVG Editing
- Visual canvas editor with real-time preview
- Modify fill colors, stroke colors, and stroke width
- Multi-layer support with selectable paths
- Undo/redo functionality
- Bounding box selection visualization

### Gallery & Discovery
- Home screen grid gallery (2-column layout)
- Search and filter by author, tags, ratings
- View SVG metadata and artist profiles
- Display ratings and upload dates

### Cloud Features
- Firebase-powered backend
- Upload and download SVG files
- User authentication (email/password)
- Profile management with photo

## Tech Stack

| Component | Technology |
|-----------|------------|
| Language | Swift |
| UI Framework | SwiftUI |
| Backend | Firebase (Auth, Database, Storage) |
| SVG Parsing | PocketSVG |
| Authentication | Firebase Auth + Google Sign-In |

## Project Structure

```
Moush_iOS/
├── Cloud/                    # Firebase integration
│   ├── Cloud.swift           # Main service singleton
│   ├── Cloud+Auth.swift      # Authentication
│   ├── Cloud+UploadSvg.swift # Upload functionality
│   └── Cloud+Downloading.swift
├── Navigation/
│   ├── Previewing/           # Gallery views
│   │   ├── HomeScreen.swift
│   │   └── ArtDisplayScreen.swift
│   ├── Editing/              # Editor views
│   │   ├── EditSvgScreen.swift
│   │   ├── CanvasView.swift
│   │   └── AttributesView.swift
│   └── CloudServices/        # Auth screens
├── svg_reading/              # SVG parsing
├── RedoSystem/               # Undo/redo logic
└── GeneralExtensions/        # Utilities
```

## Getting Started

1. Clone the repository
2. Open `Moush_iOS.xcworkspace` in Xcode
3. Configure Firebase credentials (`GoogleService-Info.plist`)
4. Build and run on iOS 14+ device/simulator

## Usage

1. **Sign up/Login** with email and password
2. **Browse** the gallery on the home screen
3. **Search** using filters (author, tags, ratings)
4. **View** detailed SVG information
5. **Edit** by selecting paths and modifying properties
6. **Upload** your edited artwork to the cloud
