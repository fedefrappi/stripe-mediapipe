# stripe-mediapipe

MediaPipe face landmarker for the Stripe iOS SDK, included through the
`Identity` package trait of `stripe-ios-spm` or the `StripeIdentity` pod.

## Versions

Package and upstream MediaPipe versions are tracked in `VERSION` and
`MEDIAPIPE_VERSION`.

| StripeMediaPipe | MediaPipeTasksVision |
|---|---|
| `1.0.0` | `0.10.21` |

## Releases

1. Update `VERSION` and the table above in a PR. Update `MEDIAPIPE_VERSION`
   when upgrading MediaPipe.
2. After merging, run **Actions > Release > Run workflow** on `main`.
   The workflow rebuilds the xcframeworks, updates manifest checksums and the
   podspec version, and publishes GitHub release assets. It also publishes the
   pod when `COCOAPODS_TRUNK_TOKEN` is configured.
3. Update the dependency in `stripe-ios`: `Package.swift`,
   `StripeIdentity.podspec`, and `StripeIdentity.xcodeproj`.

Swift Package Manager downloads the three xcframework archives from the release.
CocoaPods uses `StripeMediaPipe-<version>.zip`, containing the frameworks and
wrapper sources.

For a manual release, run:

```bash
Scripts/refresh_artifacts.sh
Scripts/make_release.sh
```

Commit the updated `Package.swift` and `StripeMediaPipe.podspec`, then run the
publishing commands printed by `make_release.sh`.
