// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

/// Android `--flavor` is forwarded as a compile-time define by the Flutter tool.
/// See `android/app/build.gradle` (`store`, `standalone`).
const String _flutterAppFlavor = String.fromEnvironment(
  'FLUTTER_APP_FLAVOR',
  defaultValue: '',
);

/// App stores build: no sideload/APK update UI and no [REQUEST_INSTALL_PACKAGES].
bool get isStoreDistribution => _flutterAppFlavor == 'store';

/// Signed sideload build distributed as a single GitHub APK named `mona-*.apk`.
bool get isStandaloneDistribution => _flutterAppFlavor == 'standalone';
