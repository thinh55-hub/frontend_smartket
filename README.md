# Frontend Setup for Smartket

## Samsung S24 Ultra Emulator Setup (macOS only)

To replicate the current development environment (Flutter + Android SDK + a Samsung S24 Ultra configured emulator) run:

```bash
chmod +x ./scripts/android-emulator-setup.sh
./scripts/android-emulator-setup.sh
```

This script:
- Ensures Homebrew + Flutter installed (macOS only).
- Installs / updates Android SDK components & accepts licenses.
- Chooses an Android API level (tries 36, then 35, then 34).
- Creates or updates an emulator named `Samsung_S24_Ultra`.
- Applies screen specs 1440x3120 @ 505dpi, 2GB RAM, 2 CPU cores.
- Disables cameras & Play Store for a lean dev image.
- Runs `flutter pub get`.

After setup:
```bash
flutter emulators --launch Samsung_S24_Ultra
flutter run
```

Re-run the script safely at any time; it is idempotent for existing resources.

## Running the App - Three Flavors

This project supports three build flavors for different development scenarios:

### **Mock Flavor** (No Backend Required)
Perfect for frontend developers who want to work on UI/UX without backend dependency.
- Uses hardcoded Vietnamese product data
- No API calls, no network needed
- App displays as "SMARTKET Mock"

```bash
flutter run --flavor mock -t lib/main_mock.dart
```

### **Dev Flavor** (Local/Development Backend)
Connects to development backend for integration testing.
- Backend URL: `http://10.0.2.2:5000/api` (Android emulator)
- Backend URL: `http://localhost:5000/api` (iOS simulator)
- App displays as "SMARTKET Dev"

```bash
flutter run --flavor dev -t lib/main_dev.dart
```

### **Prod Flavor** (Production Backend)
Production-ready build connecting to live API.
- Backend URL: TBD
- App displays as "SMARTKET"

```bash
flutter run --flavor prod -t lib/main_prod.dart
```

### **Building Release APKs**

```bash
# Mock flavor (for demos/testing)
flutter build apk --flavor mock -t lib/main_mock.dart

# Dev flavor
flutter build apk --flavor dev -t lib/main_dev.dart

# Production flavor
flutter build apk --flavor prod -t lib/main_prod.dart --release
```

For more details on flavors, see [FLAVORS.md](FLAVORS.md).
