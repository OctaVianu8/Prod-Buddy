# Prod-Buddy

A new Flutter project.

## Getting Started

### Prerequisites

Ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.

**Linux Requirements:**
If you are running on Linux (or WSL), you need the following dependencies:
```bash
sudo apt-get update
sudo apt-get install -y ninja-build clang pkg-config libgtk-3-dev liblzma-dev
```

### Running the App

**Linux Desktop:**
```bash
flutter run -d linux
```

**WSL (Web Server Mode):**
If you are using WSL and want to run in a browser on Windows:
1. Enable web support: `flutter config --enable-web`
2. Run the server:
   ```bash
   flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
   ```
3. Open [http://localhost:8080](http://localhost:8080) in your Windows browser.

## Learn More

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
