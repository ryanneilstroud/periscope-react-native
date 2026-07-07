# iOS packaging notes

This package embeds `NetworkMonitorKit` Swift source directly in the pod target.

Consumers do not need to add an SPM dependency in their app project.

## Current linking flow

1. RN autolinking resolves `ios/NetworkMonitorReactNative.podspec`
2. Pod compiles bridge + embedded `NetworkMonitorKit` Swift sources
3. App uses the JS API without additional Xcode package setup
