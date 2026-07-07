import Foundation
import React

@objc(NetworkMonitorReactNative)
final class NetworkMonitorReactNative: NSObject {
    @objc
    static func requiresMainQueueSetup() -> Bool {
        false
    }

    @objc(start:resolve:reject:)
    func start(
        _ options: NSDictionary?,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        let host = options?["host"] as? String ?? "localhost"
        let requestedPort = options?["port"] as? NSNumber
        let portValue = requestedPort?.intValue ?? 61337

        guard (1...65535).contains(portValue) else {
            reject("invalid_port", "Expected port in range 1...65535.", nil)
            return
        }

        NetworkMonitor.start(host: host, port: UInt16(portValue))
        resolve(nil)
    }

    @objc(stop:reject:)
    func stop(
        _ resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        NetworkMonitor.stop()
        resolve(nil)
    }
}
