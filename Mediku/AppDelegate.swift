//
//  AppDelegate.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/01.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var paramIndex : Int = 0 // noticelist -> noticepage로 값 전달에 사용하는 코드
    
    var DoctorList = [DoctorData]() // JsonParser위해 이용
    var callCheck : Bool = true // DoctorList에서 각 리스트 갯수 구하는 함수 호출 여부에 사용
    
    var majorCountList = [0,0,0,0,0,0,0,0,0,0,0] // 인덱스의 순서가 UI에 나타난 각 major의 카운트 값을 나타냄
    var SUMmajorCountList = [0]
    var buttonidx = 0 // 메인 페이지에서 몇번 버튼 눌렀는지 확인하기 위해
    // var subDoctorList = [DoctorData]() // 테이블 뷰를 위한 서브배열
    
    var loginCheck : Int = 0 // 로그인 여부 확인 버튼 - 로그인시 = 1 비로그인시 = 0
    
    var dict = [String:Any]() // 딕셔너리 선언 - 예약 페이지 보여주기 위해서
    
    var FamilyList = [String:Any]() // 딕셔너리 선언 - 가족을 위한 배열
    var TestFamilyList = ["CHkvY2pXuUZSvms6hkqHjb4E1dB2","KRdIUsCaCogVZShOR7tEJwKoAWz2","OuJJLJkDAWdK3waZYXkFHBRDQMH3"]
    var TestRelationAttr = ["가족1","가족2","가족3"]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        UITabBar.appearance().barTintColor = UIColor(red: 0.76, green: 0.88, blue: 0.77, alpha: 1.00)
        //UITabBar.appearance().barTintColor = .systemTeal
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

