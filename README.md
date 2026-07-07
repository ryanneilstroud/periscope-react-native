# @ryanneilstroud/network-monitor-react-native

React Native bridge for `NetworkMonitorKit` with a low-friction install path.

## Goal

Keep app integration as close as possible to standard React Native library setup:

1. `npm install @ryanneilstroud/network-monitor-react-native`
2. `npx pod-install` (iOS only, standard RN step)

No app-level SPM setup should be required by consumers.

## Recommended packaging strategy

Use CocoaPods autolinking + a vendored prebuilt `NetworkMonitorKit.xcframework` inside this package (or fetched by podspec from a release artifact). This avoids requiring end users to add SPM dependencies manually in their app project.

## Current repository state

This is a scaffold + implementation plan repository. It includes:

- RN package metadata and TS API surface skeleton
- iOS podspec stub for binary framework integration
- docs for architecture, compatibility, and release flow

## Next implementation steps

See `docs/PLAN.md`.
