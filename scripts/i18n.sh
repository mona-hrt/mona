#!/usr/bin/env bash
# Regenerates i18n Dart code from lib/i18n/*.i18next.json.

set -euo pipefail

cd "$(dirname "$0")/.."

# CI installs the pinned Flutter directly, without fvm.
if command -v fvm >/dev/null; then
  dart() { fvm dart "$@"; }
fi

dart run tool/i18n/i18next_to_slang.dart
dart run slang
dart run tool/i18n/i18next_to_android_widget_res.dart
dart run tool/i18n/sanitize_generated.dart
dart format lib/i18n/
