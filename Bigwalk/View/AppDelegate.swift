import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        KakaoSDKCommon.initSDK(appKey: "9d97f6c41c56b1564f7fad8eb23c59ab", loggingEnable:false)

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
           if (AuthApi.isKakaoTalkLoginUrl(url)) {
               return AuthController.handleOpenUrl(url: url, options: options)
           }
        
           return false
       }
}
