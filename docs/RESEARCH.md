# Research summary: React Native package strategy

## Key findings

1. For React Native libraries with native code, the standard low-friction path remains RN autolinking + CocoaPods on iOS.
2. SPM support in RN ecosystem is still not broadly universal for third-party native modules, so requiring app-level SPM setup increases integration friction and compatibility risk.
3. The most common modern scaffold workflow is `create-react-native-library` / `react-native-builder-bob`.

## What this means for your package

- **Best DX target:** app teams do normal RN install only (`npm install` + `pod install`), no manual Xcode SPM setup.
- **Implementation approach:** ship iOS native SDK as a pod-consumable artifact (preferably vendored `.xcframework`) through this package’s podspec.
- **Compatibility approach:** support both legacy and New Architecture module registration at first, then optimize for New Architecture as adoption increases.

## Source links reviewed

- React Native: Linking Libraries
  - https://reactnative.dev/docs/linking-libraries-ios
- React Native: Using Libraries
  - https://reactnative.dev/docs/libraries
- React Native (New Architecture + Swift module guidance)
  - https://reactnative.dev/docs/the-new-architecture/turbo-modules-with-swift
- react-native-builder-bob
  - https://github.com/callstack/react-native-builder-bob
