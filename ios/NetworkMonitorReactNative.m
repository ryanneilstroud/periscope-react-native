#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(NetworkMonitorReactNative, NSObject)

RCT_EXTERN_METHOD(
  start:(NSDictionary * _Nullable)options
  resolve:(RCTPromiseResolveBlock)resolve
  reject:(RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  stop:(RCTPromiseResolveBlock)resolve
  reject:(RCTPromiseRejectBlock)reject
)

@end
