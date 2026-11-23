![nursery logo title](./assets/images/title.svg)

![](./assets/images/subtitle.svg)

---

# Nursing Professional Management System
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
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

- **Flutter SDK**: `>=3.50.1`
- **Dart SDK**: `>=3.14.0` (included with Flutter)
- **Android SDK** (for Android development)
- **Xcode** (for iOS development)
- **Git** (for version control)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/ToniF03/nursery.git
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
├── main.dart                       # Application entry point
├── app_layout_state.dart           # Application layout and state management
├── l10n.yaml                       # Localization configuration
├── l10n/
│   ├── app_en.arb                  # English translations
│   ├── app_de.arb                  # German translations
│   ├── app_localizations_de.dart   # Generated localization delegate for German
│   ├── app_localizations_en.dart   # Generated localization delegate for English
│   └── app_localizations.dart      # Generated localization delegate
├── screens/
│   ├── dashboard.dart              # Main dashboard with real-time updates
│   ├── user_menu.dart              # User profile and settings menu
│   └── login/
│       └── login_screen.dart       # Secure authentication screen
│       └── register_screen.dart    # Secure registration screen
├── core/
│   ├── app_locale.dart             # Localization helper functions
│   ├── auth_gate.dart              # Authentication state management
│   └── globals.dart                # Global application state
└── widgets/
    ├── alert_card.dart             # Alert notification component
    ├── horizontal_fade_list.dart   # Horizontal list with fade effect
    ├── dashboard_info_card.dart    # Patient information display cards
    ├── not_implemented_dialog.dart # Placeholder for future features
    ├── pill.dart                   # Reusable pill-shaped UI component
    ├── timeline.dart               # Timeline visualization for schedules
    └── user_button.dart            # User profile button

test/
└── widget_test.dart                # Unit and widget tests

tool/
├── generate_database_architecture.dart  # Script to generate database architecture diagram
└── generate_uml_diagrams.dart           # Script to generate UML diagrams

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

## Database Architecture Diagram

The database architecture in the generated documentation is created dynamically from
[`assets/database_schema.yaml`](assets/database_schema.yaml). The YAML file defines
the tables, their columns, key types, layout side, and relationships.

```yaml
tables:
  - name: userData
    side: left
    columns:
      - name: id
        type: uuid
        key: PK

relationships:
  - from: userData.id
    to: auth.users.uid
```

Generate or update [`assets/images/database_architecture.svg`](assets/images/database_architecture.svg)
after changing the schema:

```bash
dart pub get
dart run tool/generate_database_architecture.dart
```

You can add more tables by adding entries to `tables`, and you can add more
column-to-column references by adding entries to `relationships`.
Relationship endpoints use the fully qualified format
`TableName.ColumnName`.

## UML Diagrams

The use-case and class diagrams are generated as separate SVG files from
[`assets/diagrams.yaml`](assets/diagrams.yaml). This keeps the diagrams editable
and avoids the very small rendering produced by the previous inline Pintora blocks.

Update `use_cases`, `classes`, `actor_links`, `includes`, and
`class_relationships` in the YAML specification, then run:

```bash
dart run tool/generate_uml_diagrams.dart
```

The generated files are:

- [`assets/images/use_case_diagram_1.svg`](assets/images/use_case_diagram_1.svg)
- [`assets/images/use_case_diagram_2.svg`](assets/images/use_case_diagram_2.svg)
- [`assets/images/class_diagram_application.svg`](assets/images/class_diagram_application.svg)
- [`assets/images/class_diagram_authentication.svg`](assets/images/class_diagram_authentication.svg)
- [`assets/images/class_diagram_dashboard.svg`](assets/images/class_diagram_dashboard.svg)
- [`assets/images/class_diagram_widgets.svg`](assets/images/class_diagram_widgets.svg)
- [`assets/images/class_diagram_services.svg`](assets/images/class_diagram_services.svg)

Compile the documentation locally with:

```bash
typst compile --root=. assets/documentation.typ assets/documentation.pdf
```

## 📦 Built With

- [Flutter](https://flutter.dev/) (3.50.1) - Cross-platform UI framework
- [Dart](https://dart.dev/) (3.14.0) - Modern, strongly-typed programming language
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

This project is intended purely for portfolio purposes and is not for public distribution. No person or organization may modify, publish, distribute, or use this project for commercial purposes without my prior written permission. I exclusively retain the right to sell this product.

## 💬 Support & Contribution

For questions, bug reports, or feature requests, please contact the developer.

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design Guidelines](https://material.io/design)
- [Flutter Best Practices](https://flutter.dev/docs/testing/best-practices)

---

**Version**: 1.0.0  
**Status**: 🔄 In Development  
**Built with**: Flutter 3.50.1 & Dart 3.14.0  
**Last Updated**: 2026
