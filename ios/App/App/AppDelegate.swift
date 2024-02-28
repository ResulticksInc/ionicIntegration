import UIKit
import FirebaseCore
import Capacitor
import CapacitorPushNotifications
import Firebase
import REIOSSDK
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var pushNotificationsHandler: PushNotificationsHandler?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                
            }
        }
        
        REiosHandler.initSdk(withAppId:"7def9b46-cb52-48c7-a858-5213b2cb5e72", notificationCategory: [],
                             success: {status in
            print("Resulticks sdk initialised with status code: \(status)")
        }) {error in
            print("Resulticks sdk failed with error: \(error)")
        }
        
        
        setDelegateFunctions()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }
    
    func application(_application: UIApplication, continue userActivity:   NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        
        // Universal Link
        REiosHandler.handleUniversalLinkWith(userActivity: userActivity, successHandler: {data in
            print("Received Deeplinking data: \(data)")
        }) {error in
            print("Deeplinking error: \(error)")
        }
        
        //Dynamic link
        REiosHandler.handleDynamicLinkWith (userActivity: userActivity, successHandler: {data in
            print("Received Deeplinking data: \(data)")
        }) {error in
            print("Deeplinking error: \(error)")
        }
        return false
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // Called when the app was launched with a url. Feel free to add additional processing here,
        // but if you want the App API to support tracking app url opens, make sure to keep this call
        return ApplicationDelegateProxy.shared.application(app, open: url, options: options)
    }
    
    

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // Called when the app was launched with an activity, including Universal Links.
        // Feel free to add additional processing here, but if you want the App API to support
        // tracking app url opens, make sure to keep this call
        return ApplicationDelegateProxy.shared.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
    private func setDelegateFunctions() {
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self as? MessagingDelegate
//        REiosHandler.deeplinkDelegate = self
//        REiosHandler.smartLinkDelegate = self
//        REiosHandler.notificationDelegate = self
    }

}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
      Messaging.messaging().token(completion: { (token, error) in
          
          AppLog.printAny(title: "Token", value: token ?? "", isShow: true)

        if let error = error {
            NotificationCenter.default.post(name: .capacitorDidFailToRegisterForRemoteNotifications, object: error)
        } else if let token = token {
            NotificationCenter.default.post(name: .capacitorDidRegisterForRemoteNotifications, object: token)
        }
      })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
        AppLog.printAny(title: "Got notification res", value: response.notification.request.content.userInfo, isShow: true)
        
        REiosHandler.setNotificationAction(response: response)
        
        completionHandler()
        
    }
    
    
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        AppLog.printAny(title: "Got FG notification", value: notification.request.content.userInfo, isShow: true)
        
        REiosHandler.setForegroundNotification(notification: notification) { (handler) in
            
            completionHandler(handler)

        }
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let _userInfo = userInfo as? [String: Any] {
            
            print("application state note: \(UIApplication.shared.applicationState)")
            
            REiosHandler.setCustomNotification(userInfo: _userInfo)
            
            
            completionHandler(.newData)
        }
    }
    internal class AppLog {
        
        static let printAny: Bool = true
        
        static func printAny(title: String, value: Any, isShow: Bool = false) {
            if AppLog.printAny && isShow {
                
                print("\n Vision Bank Log \n **** \(title) **** \n \(value) \n **** End ****")
            }
        }
    }
  

}
extension AppDelegate : REiosNotificationReceiver , REiosSmartLinkReceiver , REiosDeeplinkReceiver {
    
    func didReceiveDeeplink(data: [String : Any]) {
        
        
    }
    
    
    func didReceiveSmartLink(data: [String : Any]) {
        
    }
    
    func didReceiveResponse(data: [String : Any]) {
        
        
    }

    
}


