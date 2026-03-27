# Nursery

A comprehensive Flutter application designed for healthcare professionals to efficiently manage their daily nursing duties.

## Overview

**Nursery** is a mobile application built for nurses and healthcare workers to streamline their workflow. The app provides essential tools for patient management, team communication, and shift planning all in one intuitive interface.

## Features

- **Patient Files Management** - View and edit patient records with ease
- **Nurse Messaging** - Communicate securely with other healthcare team members
- **Shift Planning** - Manage and track your nursing shifts
- **Intuitive Dashboard** - Quick overview of your key information
- **Login System** - Secure authentication for healthcare professionals

## Get Started

### Prerequisites

- Flutter SDK: `>=3.11.3`
- Android SDK (for Android development)
- Xcode (for iOS development)
- Firebase Account (for backend services)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd nursery
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase** (coming soon)
   - Follow Firebase setup guides for Android and iOS
   - Download google-services.json (Android) and GoogleService-Info.plist (iOS)

4. **Run the application**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart              # Entry point
├── screens/
│   ├── dashboard.dart     # Main dashboard view
│   └── login/             # Authentication screens
└── widgets/
    ├── alert_card.dart
    ├── dashboard_info_card.dart
    ├── not_implemented_dialog.dart
    └── pill.dart          # Custom UI components
```

## Target Audience

This application is designed for healthcare professionals including nurses, nursing assistants, and other hospital staff who need an all-in-one solution for their daily patient care and team coordination tasks.

## Development Status

🔄 **In Development**

## Built With

- [Flutter](https://flutter.dev/) - Cross-platform UI framework
- [Dart](https://dart.dev/) - Programming language
- [Firebase](https://firebase.google.com/) - Backend services (planned)
- [Material Design](https://material.io/) - UI design system

## License

This project is private and not intended for public distribution.

## Support

For questions or issues, please contact the development team.

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase for Flutter](https://firebase.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)
