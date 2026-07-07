# iOS packaging notes

This package is designed so consumers do **not** need to add an SPM dependency in their app project.

## Recommended release flow

1. Build `NetworkMonitorKit.xcframework` in your Swift package pipeline.
2. Attach the artifact to a release (or copy into `ios/Frameworks` during packaging).
3. Ensure podspec points to the vendored framework path.
4. Publish npm package.

Consumers should only run standard React Native install steps:

1. `npm install @ryanneilstroud/network-monitor-react-native`
2. `npx pod-install`
