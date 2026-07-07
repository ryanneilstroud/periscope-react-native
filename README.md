# @ryanneilstroud/network-monitor-react-native

React Native iOS bridge for `NetworkMonitorKit` with low-friction installation.

## Status

Implemented for iOS via React Native native module + CocoaPods autolinking.

## Install

1. `npm install @ryanneilstroud/network-monitor-react-native`
2. `npx pod-install`
3. Rebuild the iOS app

No app-side SPM setup is required.

## Usage

```ts
import { NetworkMonitor } from '@ryanneilstroud/network-monitor-react-native';

await NetworkMonitor.start({
  host: '192.168.1.100', // your Mac running NetworkMonitorViewer
  port: 61337,
});
```

Stop monitoring:

```ts
await NetworkMonitor.stop();
```

You can also call named exports:

```ts
import { startNetworkMonitor, stopNetworkMonitor } from '@ryanneilstroud/network-monitor-react-native';
```

## Platform support

- iOS: supported
- Android: not implemented yet
