# Moush

A full-featured SVG editor for iOS that allows users to browse, create, and edit Scalable Vector Graphics with cloud synchronization and collaborative features.

## Features

- **SVG Gallery** - Browse SVGs in a grid layout with search, filters, and ratings
- **SVG Editor** - Interactive canvas with path selection, color editing, and stroke adjustments
- **Layer Management** - View and manage individual paths within SVG files
- **Undo/Redo System** - Command pattern-based history with up to 20 levels
- **Cloud Sync** - Upload and download SVGs via Firebase Storage
- **User Authentication** - Email/password and Google Sign-In support
- **Import Options** - Import from Google Drive, camera, or photo library

## Tech Stack

| Component | Technology |
|-----------|------------|
| Language | Swift 5.0 |
| UI Framework | SwiftUI |
| Minimum iOS | 16.2 |
| Backend | Firebase (Auth, Firestore, Storage, Realtime Database) |
| SVG Parsing | PocketSVG |
| Authentication | Firebase Auth, Google Sign-In |
| Cloud Storage | Google Drive API |

## Project Structure

```
Moush/
├── Moush_iOS/                    # Main iOS application
│   ├── Moush_iOS/
│   │   ├── Cloud/               # Firebase & cloud services
│   │   ├── Navigation/
│   │   │   ├── CloudServices/   # Login, SignUp, Upload screens
│   │   │   ├── Previewing/      # Home gallery & art display
│   │   │   └── Editing/         # SVG editor & canvas
│   │   ├── UndoRedoStack/       # Command pattern undo/redo
│   │   ├── svg_reading/         # SVG path models
│   │   ├── SearchFilters/       # Search & filter components
│   │   ├── GeneralExtensions/   # Swift extensions
│   │   ├── local_svgs/          # 39 sample SVG files
│   │   └── Assets.xcassets/     # App icons & colors
│   └── Moush_iOS.xcodeproj/
├── 00 - Art/                     # Brand assets & icons
├── 01 - Sample SVGs/             # Additional SVG samples
└── GoogleDrive/                  # Google Drive API integration
```

## Installation

### Prerequisites

- Xcode 14.0+
- CocoaPods
- Firebase account with Firestore, Storage, and Authentication enabled
- Google OAuth credentials (for Google Sign-In)

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/AmirJahan/Moush.git
   cd Moush/Moush_iOS
   ```

2. **Install dependencies**
   ```bash
   pod install
   ```

3. **Configure Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Authentication (Email/Password and Google)
   - Enable Firestore Database
   - Enable Storage
   - Download `GoogleService-Info.plist` and replace the existing one in `Moush_iOS/Moush_iOS/`

4. **Open the workspace**
   ```bash
   open Moush_iOS.xcworkspace
   ```

5. **Build and run**
   - Select an iPhone or iPad simulator (iOS 16.2+)
   - Press `Cmd+R` to build and run

## Architecture

The app follows the **MVVM** pattern:

- **Models** - `MySvg`, `PathModel` for SVG data representation
- **Views** - SwiftUI views for all screens and components
- **ViewModels** - `ViewModel` manages editor state and SVG parsing

### Key Patterns

- **Cloud Singleton** - `Cloud.inst` provides centralized Firebase access
- **Command Pattern** - Undo/redo system with `Command` protocol
- **Observable Objects** - Reactive state management with `@Published`

## Screens

| Screen | Description |
|--------|-------------|
| LoginScreen | Firebase email/password authentication |
| SignUpScreen | User registration with profile details |
| HomeScreen | SVG gallery with search and filters |
| ArtDisplayScreen | Detailed SVG view with ratings and tags |
| EditSvgScreen | Interactive SVG editor with layers panel |
| UploadSVGScreen | Upload SVGs with metadata |

## Data Models

### MySvg
```swift
struct MySvg: Identifiable, Hashable {
    var id: UUID
    var fileName: String
    var thumbName: String
    var author: String
    var tags: [String]
    var rating: Float
    var uploadDate: Date
    var filePath: String?
}
```

### PathModel
```swift
struct PathModel {
    var path: Path
    var fill: Color
    var stroke: Color
    var strokeWidth: Float
    var strokeStyle: StrokeStyle
    var boundingBox: Path?
    var visible: Bool
    var selected: Bool
}
```

## Known Limitations

- Cloud SVG display uses local data for the gallery (cloud integration in progress)
- Google Drive import has placeholder implementation
- User display name requires manual configuration after signup

## Device Support

- iPhone (all sizes)
- iPad (optimized layouts)

## Contributors

Developed by The Odd Institute with contributions from multiple development teams.

## License

All rights reserved.
