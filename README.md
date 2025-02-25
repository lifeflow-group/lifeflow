# LifeFlow

Lifeflow is a mobile application designed to help users build and maintain positive habits. It provides a system for users to track their activities, receive reminders, analyze their progress, and receive personalized suggestions for improvement.

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK: Included with Flutter
- IDE: [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/lifeflow.git
   ```
2. Navigate to the project directory:
   ```sh
   cd lifeflow
   ```
3. Get the dependencies:
   ```sh
   flutter pub get
   ```

### Running the App

1. Connect a device or start an emulator.
2. Run the app:
   ```sh
   flutter run
   ```

## Project Structure

- `lib/`: Contains the main source code for the application.
  - `core/`: Core utilities, constants, and theme definitions.
    - `constants/`: Application-wide constants such as colors, text styles, etc.
      - `app_theme.dart`
      - `colors.dart`
      - `text_styles.dart`
    - `routing/`: Routing configuration and navigation logic.
      - `app_router.dart`
  - `features/`: Feature-specific code.
    - `auth/`: Authentication-related screens and logic.
      - `presentation/`
        - `login_screen.dart`
        - `signup_screen.dart`
      - `providers/`: Riverpod providers for state management.
        - `auth_provider.dart`
        - `task_provider.dart`
    - `home/`: Home screen and related components.
      - `home_screen.dart`
    - `tasks/`: Task management screens and logic.
      - `task_list_screen.dart`
      - `task_detail_screen.dart`
  - `data/`:
    - `models/`: Data models used in the application.
      - `user_model.dart`
      - `task_model.dart`
  - `widgets/`: Reusable widgets used throughout the application.
    - `custom_button.dart`
    - `custom_text_field.dart`
  - `app.dart`
  - `main.dart`

## Dependencies & Technologies Used

- **Flutter**: UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Riverpod**: A provider-based state management solution.
- **built_value**: For immutable data models
- **Json Serializable**: Provides Dart build system builders for handling JSON.

## Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
