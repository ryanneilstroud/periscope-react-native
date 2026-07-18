# @ryanneilstroud/periscope-react-native

React Native bridge for `PeriscopeKit` (iOS) and `PeriscopeAndroid` (Android) with low-friction installation.

## Status

Implemented for iOS and Android via React Native native module autolinking.

## Install

1. Install from npm:

```bash
pnpm add @ryanneilstroud/periscope-react-native
# or: npm install @ryanneilstroud/periscope-react-native
```

2. Add `PeriscopeKit` to your app `ios/Podfile` inside your app target:

```ruby
pod 'PeriscopeKit', :git => 'https://github.com/ryanneilstroud/PeriscopeKit.git', :tag => 'v0.5.5'
```

3. `npx pod-install --repo-update` (iOS)
4. Rebuild your app

No app-side SPM setup is required.

If CocoaPods fails with:

`[!] Unable to find a specification for PeriscopeKit (= 0.5.5) depended upon by PeriscopeBridge`

it means your app Podfile does not declare where `PeriscopeKit` should come from. Add the `pod 'PeriscopeKit', :git ...` line above, then run pod install again.

## Usage

```ts
import {Periscope} from '@ryanneilstroud/periscope-react-native';

await Periscope.capture({
  receiver: {
    host: '192.168.1.100', // your Mac running Periscope Viewer
    port: 61337,
  },
});
```

Stop monitoring:

```ts
await Periscope.stop();
```

You can also call named exports:

```ts
import {capture, stop} from '@ryanneilstroud/periscope-react-native';
```

## Platform support

- iOS: supported
- Android: supported
