#!/usr/bin/env bash
# Run the Niche Hiring candidate app. Requires Flutter SDK in PATH.
set -e
cd "$(dirname "$0")"

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter not found. Install the Flutter SDK and add it to PATH:"
  echo "  https://docs.flutter.dev/get-started/install"
  exit 1
fi

if [ ! -d "android" ]; then
  echo "Generating Android/iOS platform folders..."
  flutter create . --project-name candidate_app
fi

flutter pub get
flutter run
