import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // AIzaSyDb1aqX9EjiZHTjkLko-WBAQMGIbR_zLaQ
    GMSServices.provideAPIKey("AIzaSyDb1aqX9EjiZHTjkLko-WBAQMGIbR_zLaQ")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
