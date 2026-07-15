#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(PeriscopeBridge, NSObject)

RCT_EXTERN_METHOD(
  capture:(NSDictionary * _Nullable)options
  resolve:(RCTPromiseResolveBlock)resolve
  reject:(RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  start:(NSDictionary * _Nullable)options
  resolve:(RCTPromiseResolveBlock)resolve
  reject:(RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  stop:(RCTPromiseResolveBlock)resolve
  reject:(RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  sendTestRequest:(NSString * _Nullable)urlString
  resolve:(RCTPromiseResolveBlock)resolve
  reject:(RCTPromiseRejectBlock)reject
)

@end
