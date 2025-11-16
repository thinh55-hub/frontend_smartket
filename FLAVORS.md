# SMARTKET - Multi-Flavor Configuration

This project supports three build flavors for different development stages:

## Available Flavors

### 1. **Mock** (No Backend Required)
- Uses hardcoded data
- Perfect for frontend-only development
- No API calls, no network needed
- App name: "SMARTKET Mock"

**Run commands:**
```bash
# Android
flutter run --flavor mock -t lib/main_mock.dart

# iOS
flutter run --flavor mock -t lib/main_mock.dart

# Build APK
flutter build apk --flavor mock -t lib/main_mock.dart
```

### 2. **Dev** (Development Backend)
- Connects to local/dev backend
- Base URL: `http://10.0.2.2:5003/api` (Android emulator)
- App name: "SMARTKET Dev"

**Run commands:**
```bash
# Android
flutter run --flavor dev -t lib/main_dev.dart

# iOS  
flutter run --flavor dev -t lib/main_dev.dart

# Build APK
flutter build apk --flavor dev -t lib/main_dev.dart
```

### 3. **Prod** (Production Backend)
- Connects to production API
- Base URL: `https://api.smartket.example.com/api`
- App name: "SMARTKET"

**Run commands:**
```bash
# Android
flutter run --flavor prod -t lib/main_prod.dart

# iOS
flutter run --flavor prod -t lib/main_prod.dart

# Build APK/IPA
flutter build apk --flavor prod -t lib/main_prod.dart --release
flutter build ipa --flavor prod -t lib/main_prod.dart --release
```

## Quick Start for Frontend Developers

If you're working on UI/UX and don't want to deal with backend setup:

```bash
flutter run --flavor mock -t lib/main_mock.dart
```

This launches the app with 10 pre-populated products - no backend, no database, no configuration needed!

## Architecture

```
lib/
├── main_mock.dart           # Mock flavor entry (hardcoded data)
├── main_dev.dart            # Dev flavor entry (dev API)
├── main_prod.dart           # Prod flavor entry (prod API)
├── core/
│   ├── repositories/
│   │   ├── product_repository.dart       # Real API repository
│   │   └── product_repository_mock.dart  # Mock data repository
│   └── config/
│       └── env.dart                      # Environment config
```

## VS Code Launch Configuration

Add to `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Mock",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_mock.dart",
      "args": ["--flavor", "mock"]
    },
    {
      "name": "Dev",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_dev.dart",
      "args": ["--flavor", "dev"]
    },
    {
      "name": "Prod",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_prod.dart",
      "args": ["--flavor", "prod"]
    }
  ]
}
```

## Benefits

- **Parallel Development**: Frontend and backend teams work independently
- **Offline Development**: Mock flavor works without network
- **Easy Testing**: Quickly switch between environments
- **Faster Iteration**: No need to wait for backend deployment
- **Demo Ready**: Mock flavor always works for demos

## Adding Mock Data

Edit `lib/core/repositories/product_repository_mock.dart` and add more products to the `_getMockProducts()` method.
