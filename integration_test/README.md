# E2E tests (Patrol)

End-to-end UI tests for Mona, written with [Patrol](https://patrol.leancode.co)
on top of Flutter's `integration_test`. They launch the real app and drive it
the way a user would.

## Important: where these can run

Patrol's native automation needs an **Android, iOS, or macOS** target - **not
Linux desktop**. The dev container has no KVM, so it **cannot host its own
emulator**. It can, however, drive a device/emulator that is reachable over
ADB - including one running on your **host** machine (see
[Running from the dev container](#running-from-the-dev-container) below). So the
options are:

- the dev container, attached to a host emulator/device over ADB, or
- a local machine with an Android emulator or a physical device, or
- CI - see [.github/workflows/ci-e2e.yml](../.github/workflows/ci-e2e.yml),
  which boots a KVM-accelerated emulator via `android-emulator-runner`.

Even with no device, the container can verify everything compiles, including
the instrumentation APK:

```bash
fvm dart run patrol_cli:main build android --flavor standalone
```

## One-time setup

1. `fvm flutter pub get`. This installs both the Patrol framework and the Patrol
   CLI - `patrol_cli` is a `dev_dependency` in `pubspec.yaml` (pinned in
   `pubspec.lock`), so there is **no** separate `dart pub global activate` step.
   Patrol config lives in `pubspec.yaml` under `patrol:`.
2. The CLI is invoked as `fvm dart run patrol_cli:main ...` (the `:main` is
   patrol_cli's `bin/main.dart`). In the dev container, step 1 runs
   automatically on create.
3. `fvm dart run patrol_cli:main doctor` to check your toolchain.

Native wiring already done in this branch:

- `android/app/build.gradle` - `PatrolJUnitRunner` test runner, the
  `ANDROIDX_TEST_ORCHESTRATOR` test option, and the `orchestrator` dependency.
- `android/app/src/androidTest/java/com/deliacheminot/mona/MainActivityTest.java`
  - the JUnit entrypoint Patrol uses to enumerate and run the Dart tests.

## Running

```bash
# All E2E tests on a connected emulator/device (note the flavor - the app
# defines store/standalone flavors, so a flavor is required). Omitting --target
# auto-discovers every *_test.dart under integration_test/:
fvm dart run patrol_cli:main test --flavor standalone

# A single file:
fvm dart run patrol_cli:main test --flavor standalone \
  --target integration_test/schedules_test.dart
```

### Running from the dev container

The container can't host an emulator, but it can attach to one running on your
**host** over ADB. `devcontainer.json` adds
`--add-host=host.docker.internal:host-gateway` so the host is resolvable.

```bash
# On the HOST, with an emulator or device running:
adb tcpip 5555            # switch the device to TCP/IP mode

# Inside the dev container:
adb connect host.docker.internal:5555
adb devices               # confirm the device is listed
fvm dart run patrol_cli:main test --flavor standalone
```

### Flavors, the `.dev` suffix, and not wiping a real install

Debug builds append `applicationIdSuffix ".dev"`
(`android/app/build.gradle`), so the package installed during tests is
`com.deliacheminot.mona.dev` - deliberately separate from a released
`com.deliacheminot.mona`. `pubspec.yaml` sets `patrol.android.package_name` to
the `.dev` id to match, so Patrol only ever manages the test build.

> **Do not point `package_name` at the base id `com.deliacheminot.mona`.**
> Patrol uninstalls/reinstalls that package, and `clearPackageData` (enabled in
> `build.gradle` for test isolation) runs `pm clear` on it between tests - so
> targeting the base id would **erase a production Mona install and all its
> data**. Even with the `.dev` split, prefer running E2E on a dedicated
> emulator or throwaway device rather than a phone holding real data: a debug
> (`flutter run`) install of the app *also* lives at `.dev` and would be wiped.

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
3. Run `fvm dart run patrol_cli:main test --target integration_test/schedules_test.dart`
   on a Simulator from macOS.

See the [Patrol iOS setup docs](https://patrol.leancode.co/documentation).
