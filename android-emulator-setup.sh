#!/usr/bin/env bash
set -euo pipefail

# SMARTKET Developer Environment Setup (macOS)
# Replicates current Flutter + Android SDK + Samsung S24 Ultra emulator config.
# Safe to re-run; idempotent where possible.

EMULATOR_NAME="Samsung_S24_Ultra"
API_FALLBACK="35"            # Fallback API level if target not found
TARGET_DENSITY=505
TARGET_WIDTH=1440
TARGET_HEIGHT=3120
TARGET_RAM_MB=2048
TARGET_CPU_CORES=2
SYSTEM_IMAGE_VARIANT="google_apis"
ABI="arm64-v8a"

echo "\n=== SMARTKET DEV ENV SETUP ===\n"

if [[ "$(uname)" != "Darwin" ]]; then
  echo "This script currently supports macOS only." >&2
  exit 1
fi

command -v xcode-select >/dev/null || {
  echo "(Optional) Install Xcode command line tools for full functionality: xcode-select --install";
}

if ! command -v brew >/dev/null; then
  echo "Homebrew missing. Installing...";
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || true
fi

echo "Updating Homebrew packages..."
brew update

echo "Installing base utilities (git, wget, unzip)..."
brew install git wget unzip || true

if ! command -v flutter >/dev/null; then
  echo "Installing Flutter SDK via Homebrew..."
  brew install flutter
fi

echo "Flutter version: $(flutter --version | head -1)"

ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT
mkdir -p "$ANDROID_SDK_ROOT"

if ! command -v sdkmanager >/dev/null; then
  echo "Ensuring cmdline-tools (Android) present..."
  # Install via Homebrew if Android Studio not present
  if [[ ! -d "/Applications/Android Studio.app" ]]; then
    echo "Installing Android Studio (cask)..."
    brew install --cask android-studio
    echo "Open Android Studio once to finalize SDK setup, then re-run script if sdkmanager still missing.";
  fi
fi

if command -v sdkmanager >/dev/null; then
  echo "Accepting Android SDK licenses..."
  yes | sdkmanager --licenses >/dev/null || true

  echo "Querying available platforms..."
  AVAILABLE=$(sdkmanager --list | awk '/platforms;android-[0-9]+/{print $1}' | sed 's/platforms;//' | cut -d- -f2)
  TARGET_API=""
  for v in 36 35 34; do
    if echo "$AVAILABLE" | grep -q "^$v$"; then TARGET_API="$v"; break; fi
  done
  if [[ -z "$TARGET_API" ]]; then TARGET_API="$API_FALLBACK"; fi
  echo "Chosen Android API level: $TARGET_API"

  echo "Installing required SDK components (platform + build-tools + system image)..."
  sdkmanager "platform-tools" \
             "platforms;android-$TARGET_API" \
             "build-tools;35.0.0" || true

  IMAGE_PKG="system-images;android-$TARGET_API;$SYSTEM_IMAGE_VARIANT;$ABI"
  sdkmanager "$IMAGE_PKG" || {
    echo "Failed to install system image $IMAGE_PKG. Attempting default google_apis image.";
    sdkmanager "system-images;android-$TARGET_API;google_apis;$ABI" || true
  }
else
  echo "WARNING: sdkmanager unavailable. Emulator creation will be skipped. Launch Android Studio, install SDK, then re-run.";
fi

if command -v avdmanager >/dev/null; then
  echo "\nHandling emulator '$EMULATOR_NAME'..."
  AVD_DIR="$HOME/.android/avd"
  INI_FILE="$AVD_DIR/$EMULATOR_NAME.ini"
  if [[ -f "$INI_FILE" ]]; then
    echo "Emulator already exists. Skipping creation.";
  else
    echo "Creating AVD..."
    avdmanager create avd -n "$EMULATOR_NAME" -k "system-images;android-$TARGET_API;$SYSTEM_IMAGE_VARIANT;$ABI" -d "pixel_5" --force || {
      echo "Primary device template failed. Retrying with 'Nexus 5'.";
      avdmanager create avd -n "$EMULATOR_NAME" -k "system-images;android-$TARGET_API;$SYSTEM_IMAGE_VARIANT;$ABI" -d "Nexus 5" --force || true
    }
  fi

  CONFIG_FILE="$AVD_DIR/${EMULATOR_NAME}.avd/config.ini"
  if [[ -f "$CONFIG_FILE" ]]; then
    echo "Applying Samsung S24 Ultra display + hardware overrides..."
    # Use perl -pi to edit or append if missing
    perl -0777 -pi -e "s/hw.lcd.width=.*/hw.lcd.width=$TARGET_WIDTH/; s/hw.lcd.height=.*/hw.lcd.height=$TARGET_HEIGHT/; s/hw.lcd.density=.*/hw.lcd.density=$TARGET_DENSITY/; s/hw.ramSize=.*/hw.ramSize=${TARGET_RAM_MB}M/; s/hw.cpu.ncore=.*/hw.cpu.ncore=$TARGET_CPU_CORES/; s/PlayStore.enabled=.*/PlayStore.enabled=no/" "$CONFIG_FILE" || true
    grep -q "avd.ini.displayname=" "$CONFIG_FILE" || echo "avd.ini.displayname=Samsung S24 Ultra" >> "$CONFIG_FILE"
    perl -0777 -pi -e "s/hw.camera.back=.*/hw.camera.back=none/; s/hw.camera.front=.*/hw.camera.front=none/" "$CONFIG_FILE" || true
    echo "Updated config:"
    grep -E "hw.lcd.width|hw.lcd.height|hw.lcd.density|hw.ramSize|hw.cpu.ncore|camera|PlayStore.enabled|displayname" "$CONFIG_FILE"
  else
    echo "Emulator config file not found (creation may have failed).";
  fi
else
  echo "avdmanager not available; skipping emulator provisioning.";
fi

echo "\nRunning flutter pub get..."
flutter pub get || true

echo "\n=== SUMMARY ==="
echo "Flutter SDK: $(which flutter)"
echo "Android SDK Root: $ANDROID_SDK_ROOT"
echo "Emulator: $EMULATOR_NAME (target API $TARGET_API)"
echo "Display: ${TARGET_WIDTH}x${TARGET_HEIGHT}@${TARGET_DENSITY}dpi, RAM ${TARGET_RAM_MB}MB, CPU cores ${TARGET_CPU_CORES}"
echo "Run emulator: flutter emulators --launch $EMULATOR_NAME"  
echo "Run app: flutter run -d emulator-5554 (device id may vary)" 
echo "\nDone."
