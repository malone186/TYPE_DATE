#!/bin/bash
set -euo pipefail

FLUTTER_VERSION="stable"
FLUTTER_DIR="$HOME/flutter"

if [ ! -d "$FLUTTER_DIR" ]; then
  git clone --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

flutter config --enable-web
flutter pub get
flutter build web --release
