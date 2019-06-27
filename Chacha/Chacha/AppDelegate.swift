//
//  AppDelegate.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/25.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // Beacon & location properties
  
  var locationManager = CLLocationManager()
  // 이부분 다운로드 하는방향으로 바꿔야함
  let uuid = UUID(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825")!
  // 여기도 다운로드 끝나고 위에꺼에 옵져버 달아서 그때그때 바꿔줘야할듯 인나서 해야징
  lazy var beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "iBeacon")
  // 이건 차차가 할꺼야
  var baseUUID: String? {
    return UserDefaults.standard.string(forKey: "uuid")
  }
  
  var window: UIWindow?
  let mainVC = MainVC()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    setupBeacon()
    checkUUID()
    // 파베초기화
    Firebase.shared.firebaseInitialize()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = mainVC
    window?.backgroundColor = .white
    window?.makeKeyAndVisible()
    
    return true
  }
  
  // app이 active상태가 될 때 마다 setupBeacon을 실행하며, 위치권한 확인
  func applicationDidBecomeActive(_ application: UIApplication) {
    checkUUID()
    setupBeacon()
  }
  
  private func setupBeacon() {
    locationManager = CLLocationManager.init()
    // locationManager 초기화.
    locationManager.delegate = self
    // 델리게이트 넣어줌.
    locationManager.requestAlwaysAuthorization()
    // 위치 권한 받아옴.
    locationManager.startUpdatingLocation()
    // 위치 업데이트 시작
    locationManager.allowsBackgroundLocationUpdates = true
    // 백그라운드에서도 위치를 체크할 것인지에 대한 여부. 필요없으면 false로 처리하자.
    locationManager.pausesLocationUpdatesAutomatically = false
    // 이걸 써줘야 백그라운드에서 멈추지 않고 돈다
  }
  
  // Userdefault에 uuid 값 유무 체크
  private func checkUUID() {
    guard baseUUID == nil else { return }
    print("uuid 없음")
    mainVC.present(RegisterVC(), animated: true)
  }
  
  // 위치에 관한 권한이 always가 아닐경우 설정으로 묻지도 따지지도않고 바로이동
  // always가 아닐경우 아무고또 모타징~~~
  func moveToSetting() {
    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
  }
  
  // 알람!
  func makeAlert(completion: @escaping () -> ()) {
    let alert = UIAlertController(title: "위치권한 오류", message: "위치 권한을 항상 허용으로 해야만 출석체크가 가능합니다.", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "네", style: .destructive) { (_) in
      completion()
    }
    alert.addAction(cancelAction)
    // appdelegate에서 바로 못띄움 mainVC에 함수 만들어도 될거같은데...
    mainVC.present(alert, animated: true)
  }
  
}

