import type { NativeNetworkMonitorSpec, StartOptions } from './specs/NativeNetworkMonitor';

const MODULE_NAME = 'NetworkMonitorReactNative';

function missingNativeModuleError(): never {
  throw new Error(
    `${MODULE_NAME} is not linked. Rebuild the app after installing the package and running pod install on iOS.`
  );
}

function getNativeModule(): NativeNetworkMonitorSpec {
  // Kept lightweight for scaffold; switch to TurboModuleRegistry in implementation phase.
  const rn = require('react-native');
  const nativeModule = rn.NativeModules?.[MODULE_NAME] as NativeNetworkMonitorSpec | undefined;
  if (!nativeModule) missingNativeModuleError();
  return nativeModule;
}

export async function startNetworkMonitor(options?: StartOptions): Promise<void> {
  return getNativeModule().start(options);
}

export async function stopNetworkMonitor(): Promise<void> {
  return getNativeModule().stop();
}
