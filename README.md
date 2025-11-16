# Frontend Setup for Smartket

## Samsung S24 Ultra Emulator Setup For MacOS Only

To replicate the current development environment (Flutter + Android SDK + a Samsung S24 Ultra configured emulator) run:

```bash
chmod +x android-emulator-setup.sh
./android-emulator-setup.sh
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
