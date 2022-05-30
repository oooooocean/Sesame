import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var vc:FlutterViewController?;
    var metodChannel:FlutterMethodChannel?;
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      vc =  self.window.rootViewController as? FlutterViewController;//fluttevc
      
      metodChannel =  FlutterMethodChannel.init(name: "minePage/method", binaryMessenger: self.vc!.binaryMessenger);
    
      
      
      metodChannel?.setMethodCallHandler {(call:FlutterMethodCall, result: @escaping FlutterResult) in
          if (call.method == "pictureMethod"){
              let pickVC: UIImagePickerController = UIImagePickerController.init();
              pickVC.delegate = self;
              self.vc?.present(pickVC, animated: true, completion: nil);
              
              
          }
      }
      
      
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      
      
  }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker .dismiss(animated: true) {
            
            let Str:NSURL = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerImageURL")] as! NSURL;
            
        
            self.metodChannel?.invokeMethod("imagePath", arguments: Str.absoluteString);
            
            
        }
        print(info);
    }
}
