import Flutter
import UIKit

public class SwiftAgentDartAuthPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "agent_dart_auth", binaryMessenger: registrar.messenger())
    let instance = SwiftAgentDartAuthPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
