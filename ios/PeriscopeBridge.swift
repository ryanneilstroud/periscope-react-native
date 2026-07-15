import Foundation
import PeriscopeKit
import React

@objc(PeriscopeBridge)
final class PeriscopeBridge: NSObject {
    @objc
    static func requiresMainQueueSetup() -> Bool {
        false
    }

    @objc(capture:resolve:reject:)
    func capture(
        _ options: NSDictionary?,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        let receiverOptions = (options?["receiver"] as? NSDictionary) ?? options
        let host = (receiverOptions?["host"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
        let requestedPort = receiverOptions?["port"] as? NSNumber
        let portValue = requestedPort?.intValue ?? 61337

        guard (1...65535).contains(portValue) else {
            reject("invalid_port", "Expected port in range 1...65535.", nil)
            return
        }

        let receiver: Periscope.Receiver
        if let host, !host.isEmpty {
            receiver = .device(host: host, port: portValue)
        } else {
            receiver = .simulator(port: portValue)
        }

        Periscope.capture(for: receiver)
        resolve(nil)
    }

    @objc(start:resolve:reject:)
    func start(
        _ options: NSDictionary?,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        capture(options, resolve: resolve, reject: reject)
    }

    @objc(stop:reject:)
    func stop(
        _ resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        Periscope.stop()
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
        Periscope.inject(into: configuration)
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
