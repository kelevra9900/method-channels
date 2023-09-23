import UIKit
import Flutter
import Foundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "com.example/bidirectional_channel"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        let methodChannel = FlutterMethodChannel(
            name: CHANNEL,
            binaryMessenger: self.binaryMessenger
        )

        methodChannel.setMethodCallHandler { (call, result) in
            if call.method == "flutterToNative" {
                if let messageFromFlutter = call.arguments as? String {
                    // Procesar el mensaje desde Flutter y devolver una respuesta
                    let response = "Received from Flutter: \(messageFromFlutter)"
                    result(response)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument", details: nil))
                }
            } else if call.method == "nativeToFlutter" {
                let messageFromNative = "Hello from Native"
                methodChannel.invokeMethod("updateMessageFromNative", arguments: messageFromNative)
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
