import UIKit
import Flutter
import AMapLocationKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, AMapLocationManagerDelegate {
    
    var locationManager = AMapLocationManager()
    
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        locationManager.delegate = self
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func amapLocationManager(
    _ manager: AMapLocationManager!,
    doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestAlwaysAuthorization()
    }
}
