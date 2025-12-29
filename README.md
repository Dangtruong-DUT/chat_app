# Chat App

A modern Flutter-based chat application featuring real-time messaging, user authentication, search functionality, and customizable themes. Built with clean architecture principles for scalability and maintainability.

## Features

- **User Authentication**: Secure login and registration system
- **Real-time Chat**: Instant messaging with message history
- **User Search**: Find and connect with other users
- **Theme Support**: Light and dark theme modes with persistence
- **Internationalization**: Support for English and Vietnamese languages
- **Responsive Design**: Optimized for multiple platforms (iOS, Android, Web, Desktop)

## Technologies Used

### Core Framework
- **Flutter**: Cross-platform UI framework (SDK ^3.10.1)

### State Management
- **Bloc**: Business logic component pattern for predictable state management
- **Flutter Bloc**: Flutter integration for Bloc

### Dependency Injection
- **GetIt**: Service locator for dependency injection

### Networking
- **HTTP**: Package for making HTTP requests

### Routing
- **Go Router**: Declarative routing for Flutter

### Storage
- **Shared Preferences**: Local data persistence

### UI & Assets
- **Flutter SVG**: SVG image support
- **Lottie**: Animation library
- **Cupertino Icons**: iOS-style icons

### Utilities
- **Timeago**: Human-readable time formatting
- **Equatable**: Value equality for Dart objects
- **Dartz**: Functional programming helpers
- **Easy Localization**: Internationalization support
- **Collection**: Enhanced collection data structures

## Project Structure

This project follows a clean architecture approach with feature-based organization:

```
lib/
├── main.dart                    # Application entry point
└── src/
    ├── app.dart                 # Root widget and app configuration
    ├── app_injection.dart       # Dependency injection setup
    ├── core/                    # Core utilities and configurations
    │   ├── bloc/                # Base BLoC classes
    │   ├── i18n/                # Internationalization
    │   ├── router/              # App routing configuration
    │   ├── theme/               # Theme definitions
    │   └── utils/               # Utility functions
    ├── features/                # Feature modules
    │   ├── auth/                # Authentication feature
    │   ├── chats/                # Chat functionality
    │   ├── search/              # User search
    │   └── setting/             # App settings
    └── shared/                  # Shared components
        ├── data/                # Data layer (repositories, data sources)
        ├── domain/              # Domain layer (entities, use cases)
        └── presentation/        # Shared presentation components
```

## Architecture

The app implements Clean Architecture with three main layers:

### Presentation Layer
- Widgets and UI components
- BLoC pattern for state management
- Event-driven UI updates

### Domain Layer
- Business logic entities
- Use cases (application logic)
- Repository interfaces

### Data Layer
- Repository implementations
- Data sources (API, local storage)
- Data models and mappers

## Getting Started

### Prerequisites
- Flutter SDK (^3.10.1)
- Dart SDK (included with Flutter)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Dangtruong-DUT/chat_app.git
   cd chat_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Building for Production

#### Android
```bash
flutter build apk
```

#### iOS
```bash
flutter build ios
```

#### Web
```bash
flutter build web
```

## Configuration

### Environment Setup
The app uses environment-specific configurations defined in `pubspec.yaml`.

### Assets
Static assets are organized in the `assets/` directory:
- `svg/`: Vector graphics
- `images/common/`: Common UI images
- `images/chats/`: Chat-related images
- `lotties/`: Animation files
- `translations/`: Localization files

### Localization
Translation files are located in `assets/translations/` and support English (`en`) and Vietnamese (`vi`).

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-12-29 05:45:03
Current User's Login: Dangtruong-DUT