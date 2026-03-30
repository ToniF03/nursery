# Nursery - Nursing Professional Management System

A modern, cross-platform Flutter application designed for healthcare professionals to efficiently manage their daily nursing duties and improve patient care coordination.

## Overview

**Nursery** is a comprehensive mobile and desktop application built for nurses, nursing assistants, and healthcare workers to streamline their workflow. The app provides essential tools for patient management, real-time alerts, team communication, and shift planning all in one intuitive interface.

## ✨ Features

- **📊 Intelligent Dashboard** - Real-time overview of patient information and key metrics with live clock synchronization
- **🚨 Smart Alert System** - Immediate notifications for critical patient events and important care reminders
- **📅 Timeline View** - Visual representation of medication schedules, appointments, and daily patient care activities
- **🔍 Quick Search** - Rapidly access patient files and information across the system
- **👥 Patient Files Management** - Complete view and management of patient records with organized information cards
- **💬 Team Collaboration** - Secure messaging with healthcare team members for coordinated care
- **🔐 Login System** - Secure authentication with role-based access control for healthcare professionals
- **⏰ Shift Planning** - Comprehensive shift management and nurse scheduling system

## 🌍 Platform Support

This application runs seamlessly on multiple platforms:

- 📱 **Mobile**: Android and iOS
- 🌐 **Web**: Browser-based access for any device
- 🖥️ **Desktop**: Windows, macOS, and Linux support

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: `>=3.11.3`
- **Dart SDK**: (included with Flutter)
- **Android SDK** (for Android development)
- **Xcode** (for iOS development)
- **Git** (for version control)

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

3. **Run the application**
   
   For mobile devices:
   ```bash
   flutter run
   ```
   
   For web:
   ```bash
   flutter run -d chrome
   ```
   
   For desktop (Windows/macOS/Linux):
   ```bash
   flutter run -d windows    # or macos, linux
   ```

## 📁 Project Structure

```
lib/
├── main.dart                      # Application entry point
├── app_layout_state.dart          # Application layout and state management
├── screens/
│   ├── dashboard.dart             # Main dashboard with real-time updates
│   └── login/
│       └── login_screen.dart      # Secure authentication screen
└── widgets/
    ├── alert_card.dart            # Alert notification component
    ├── dashboard_info_card.dart    # Patient information display cards
    ├── pill.dart                   # Reusable pill-shaped UI component
    ├── timeline.dart               # Timeline visualization for schedules
    └── not_implemented_dialog.dart # Placeholder for future features

test/
└── widget_test.dart                # Unit and widget tests

android/, ios/, web/, windows/, macos/, linux/
└── Platform-specific configurations and native code
```

## 🎯 Target Audience

This application is designed for healthcare professionals including:
- Registered Nurses (RNs)
- Licensed Practical Nurses (LPNs)
- Nursing Assistants (NAs)
- Clinical Staff
- Hospital and Healthcare Facility Workers

## 🛠️ Development

### Running Tests

Execute the test suite:
```bash
flutter test
```

### Building for Release

**Android**:
```bash
flutter build apk
flutter build appbundle  # for Google Play Store
```

**iOS**:
```bash
flutter build ios
```

**Web**:
```bash
flutter build web
```

**Desktop** (Windows/macOS/Linux):
```bash
flutter build windows   # or macos, linux
```

### Code Style & Linting

This project follows Flutter and Dart best practices with analysis enabled via `analysis_options.yaml`. Run linting with:
```bash
flutter analyze
```

## 🏗️ Architecture

The application uses:
- **Stateful Widgets**: For dynamic, responsive UI updates
- **Material Design**: Modern, accessible UI components
- **State Management**: Currently using direct setState() (ready to scale to Provider, BLoC, or Riverpod patterns)
- **Responsive Layout**: Adapts to mobile, tablet, and desktop screen sizes

## 📦 Built With

- [Flutter](https://flutter.dev/) - Cross-platform UI framework
- [Dart](https://dart.dev/) - Modern, strongly-typed programming language
- [Material Design](https://material.io/) - Google's design system
- [Cupertino Icons](https://pub.dev/packages/cupertino_icons) - iOS-style icon set
- [Flutter Lints](https://pub.dev/packages/flutter_lints) - Recommended linting rules

## 🔮 Planned Features & Enhancements

- 🔄 Real-time push notifications
- 📸 Patient photo and medical records integration
- 💬 Advanced team messaging with notification preferences
- 📊 Comprehensive analytics and reporting dashboard
- 🔗 Electronic Health Records (EHR) integration
- 📱 Offline mode with data synchronization
- 🌐 Multi-language support
- ♿ Enhanced accessibility features

## 📄 License

This project is private and not intended for public distribution.

## 💬 Support & Contribution

For questions, bug reports, or feature requests, please contact the development team.

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design Guidelines](https://material.io/design)
- [Flutter Best Practices](https://flutter.dev/docs/testing/best-practices)

---

**Version**: 1.0.0  
**Status**: 🔄 In Development  
**Built with**: Flutter 3.11.3+  
**Last Updated**: 2026
