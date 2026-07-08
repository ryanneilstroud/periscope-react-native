import Foundation
import NetworkMonitorKit
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

    @objc(sendTestRequest:resolve:reject:)
    func sendTestRequest(
        _ urlString: NSString?,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        let targetURLString = (urlString as String?)?.trimmingCharacters(in: .whitespacesAndNewlines)
        let resolvedURLString = (targetURLString?.isEmpty == false)
            ? targetURLString!
            : "https://jsonplaceholder.typicode.com/todos/1"

        guard let url = URL(string: resolvedURLString) else {
            reject("invalid_url", "sendTestRequest expected a valid URL string.", nil)
            return
        }

        let configuration = URLSessionConfiguration.default
        NetworkMonitor.inject(into: configuration)
        let session = URLSession(configuration: configuration)

        session.dataTask(with: url) { _, response, error in
            defer { session.finishTasksAndInvalidate() }

            if let error {
                reject("request_failed", error.localizedDescription, error)
                return
            }

            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            resolve(statusCode)
        }.resume()
    }
}
