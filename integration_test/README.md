# E2E tests (Patrol)

End-to-end UI tests for Mona, written with [Patrol](https://patrol.leancode.co)
on top of Flutter's `integration_test`. They launch the real app and drive it
the way a user would.

## Important: where these can run

Patrol's native automation supports **Android, iOS, macOS** - **not Linux
desktop**. The dev container only has a Linux desktop target and no
KVM/emulator, so these tests **cannot run inside the container**. Run them on:

- a local machine with an Android emulator or a physical device, or
- CI - see [.github/workflows/ci-e2e.yml](../.github/workflows/ci-e2e.yml),
  which boots a KVM-accelerated emulator via `android-emulator-runner`.

What *can* be verified in the container is that everything compiles, including
the instrumentation APK:

```bash
patrol build android --flavor standalone
```

## One-time setup

1. `fvm flutter pub get` (Patrol config lives in `pubspec.yaml` under `patrol:`).
2. Install the CLI: `fvm dart pub global activate patrol_cli` and make sure
   `~/.pub-cache/bin` is on your `PATH`.
3. `patrol doctor` to check your toolchain.

Native wiring already done in this branch:

- `android/app/build.gradle` - `PatrolJUnitRunner` test runner, the
  `ANDROIDX_TEST_ORCHESTRATOR` test option, and the `orchestrator` dependency.
- `android/app/src/androidTest/java/com/deliacheminot/mona/MainActivityTest.java`
  - the JUnit entrypoint Patrol uses to enumerate and run the Dart tests.

## Running

```bash
# All E2E tests on a running emulator/device (note the flavor - the app
# defines store/standalone flavors, so a flavor is required):
patrol test --flavor standalone

# A single file:
patrol test --flavor standalone --target integration_test/schedules_test.dart
```

### Flavors and the `.dev` suffix

Debug builds append `applicationIdSuffix ".dev"`
(`android/app/build.gradle`), so the package installed during tests is
`com.deliacheminot.mona.dev`. `pubspec.yaml` sets `patrol.android.package_name`
to the base id `com.deliacheminot.mona`. If Patrol can't find the app under
test, change it to `com.deliacheminot.mona.dev`.

## Writing tests - notes for this app

The schedules UI defines **no widget `Key`s**, so tests target widgets by their
visible (English) label, e.g. `$(TextField).containing('Name')`. This is
deliberate: when a route is pushed the previous route stays mounted, so
index-based `TextField` finders are ambiguous across the navigation stack -
prefer label-scoped finders. If the UI strings change, update the `const`
labels at the top of the test file.

## iOS (follow-up - not yet wired)

The chosen target is Android-in-CI, and iOS requires Xcode project changes that
can't be made or verified from this Linux container. To add iOS later:

1. Add a `RunnerTests` target / Patrol test bundle in `ios/Runner.xcodeproj`.
2. Confirm `patrol.ios.bundle_id` in `pubspec.yaml` matches the app's bundle id.
3. Run `patrol test --target integration_test/schedules_test.dart` on a Simulator
   from macOS.

See the [Patrol iOS setup docs](https://patrol.leancode.co/documentation).
