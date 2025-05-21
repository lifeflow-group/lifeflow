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

## Setting up API Key for Translation

To use the automatic translation features, you need to set up a Google API key that has access to the Gemini API or Google Translate API:

1. **Create `.env` file**:
   - Copy the `.env.example` file to create your own `.env` file:
     ```sh
     cp .env.example .env
     ```
   - Edit the `.env` file and replace `YOUR_API_KEY_HERE` with your actual Google API key.

2. **Using Environment Variables** (alternative method):
   - You can also set the API key as an environment variable:
     ```sh
     # On Windows:
     set ARB_TRANSLATE_API_KEY=YOUR_API_KEY_HERE

     # On macOS/Linux:
     export ARB_TRANSLATE_API_KEY=YOUR_API_KEY_HERE
     ```

3. **Generate Translations**:
   - To translate messages to all supported languages:
     ```sh
     arb_translate
     ```
   - To translate to a specific language (e.g., Vietnamese):
     ```sh
     arb_translate -s lib/l10n/app_en.arb -t lib/l10n/app_vi.arb -l vi
     ```

## Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
