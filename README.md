# Animated Card Stack Finance App
A modern, interactive Flutter-based mobile application designed to provide a visually engaging way to manage credit cards and track financial transactions. The app features a 3D card stack with parallax scrolling, card flip animations, and AI-powered spending insights, making it both functional and delightful to use. Built with clean architecture, SOLID principles, and state management using the BLoC pattern, it serves as a showcase for advanced Flutter UI and financial app development.
# Key Features

## 3D Card Stack with Parallax Scrolling: 

Displays credit cards in a 3D stack using PageView with smooth parallax effects via Transform widgets.
Cards scale and translate dynamically as users swipe horizontally, creating a premium, immersive experience.


## Card Flip Animations: 

Tap a card to flip it, revealing transaction details on the back with a smooth 3D rotation animation.
Uses AnimatedBuilder and Transform for realistic flip effects, with customizable gradients per card type (Visa, Mastercard, etc.).


## Swipe Gestures with Spring Physics: 

Cards respond to swipe gestures with natural, spring-based animations for a tactile feel.
Implemented using PageController with AlwaysScrollableScrollPhysics.


## Spending Insights with Animated Charts:

Aggregates transaction data by category (e.g., Coffee, Shopping) and displays an interactive pie chart using the fl_chart package.
Animates on load with easing curves for a polished effect.
Provides "AI-like" insights, such as projected monthly spending and personalized budgeting tips (e.g., "Consider budgeting Rs. 5000 for Shopping").
Accessible via a dedicated InsightsScreen, showing both recent transactions and the pie chart.


## Interactive Transaction List:

Displays recent transactions with slide-in animations and color-coded icons (red for expenses, green for income).
Supports dynamic updates via the BLoC pattern, with mock data for testing.


## Lottie Animations for Splash Screen:

Engaging splash screen with a Lottie animation (card.json) and a loader widget for a smooth onboarding experience.
Automatically navigates to the card stack after a 3-second delay.


## Clean Architecture and SOLID Principles:

Uses dependency injection (GetIt) for services like SpendingInsightsService.
Implements BLoC for state management, ensuring separation of concerns.
Modular structure with domain, presentation, and core layers for maintainability.


## Customizable Card Designs:

Supports multiple card types (Visa, Mastercard, Dollar Card) with distinct gradients, logos, and patterns.
Includes realistic card elements like chip, magnetic strip, and contactless icon.



# Screensh

https://github.com/user-attachments/assets/3fbf2725-80b2-45d8-bcb0-f39f6194183e

ots


- Flutter SDK: >=3.0.0
- Dart: >=3.0.0
- IDE: VS Code or Android Studio with Flutter plugin
- Emulator or physical device for testing

# Installation

    Clone the repository:
    git clone https://github.com/yourusername/animated-card-stack-finance.git
    cd animated-card-stack-finance


    Install dependencies:
    flutter pub get

# Ensure required packages are included in pubspec.yaml:dependencies:
  - flutter:
    - sdk: flutter
  - flutter_bloc: ^8.1.3
  - injectable: ^2.1.0
  - get_it: ^7.2.0
  - fl_chart: ^0.68.0
  - lottie: ^3.1.2
  - flutter_localization: ^0.2.0


## Run the app:
    flutter run



# Project Structure
    lib/
    ├── core/                     # Core utilities and services
    │   ├── constants/            # Colors, enums, etc.
    │   ├── services/             # Dependency injection and SpendingInsightsService
    │   └── widgets/              # Reusable widgets (e.g., LoaderWidget)
    ├── features/                 # Feature-specific code
    │   └── cards/                # Card-related functionality
    │       ├── bloc/             # BLoC for state management
    │       ├── domain/           # Models (CreditCard, SpendingInsight, Transaction)
    │       ├── presentation/           # UI screens (CardStackScreen, InsightsScreen) 
    │       └── widgets/          # Card and transaction widgets
    ├── main.dart                 # App entry point

# Usage

Launch the app to see the splash screen with a Lottie animation.
Swipe through the 3D card stack to view different credit cards.
Tap a card to flip it and see details like balance and CVV.
Press the "Insights" icon in the app bar to view transactions and a pie chart with spending insights for the selected card.
Interact with the pie chart to highlight categories and view AI-generated tips.

# Future Enhancements
- Biometric Authentication: Add local_auth for secure card access.
- Voice Commands: Integrate speech_to_text for hands-free navigation.
- Budget Tracker: Allow users to set budgets with animated progress bars.
- P2P Transfers: Implement QR code-based mock transfers using mobile_scanner and qr_flutter.

# Contributing
## Contributions are welcome! Please:

- Fork the repository.
- Create a feature branch (git checkout -b feature/YourFeature).
- Commit changes (git commit -m 'Add YourFeature').
- Push to the branch (git push origin feature/YourFeature).
- Open a pull request.

### Flutter for the framework.
### fl_chart for animated pie charts.
### flutter_bloc for state management.
### Lottie for splash screen animations.
