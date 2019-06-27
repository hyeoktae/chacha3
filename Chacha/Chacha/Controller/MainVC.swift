//
//  MainVC.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/25.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

final class MainVC: UIViewController {
  let shared = Firebase.shared
  // private 안됨 appdelegate에서 사용
  var myUUID = UserDefaults.standard.string(forKey: "uuid")
  
  private let mainView = MainView()
  
  private let registerVC = RegisterVC()
  private let checkVC = CheckVC()
  private let detailCheckVC = DetailCheckVC()
  private let adminVC = AdminVC()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    mainView.delegate = self
    setupMainView()
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // 이부분 임의로 사용하기 위해 주석처리
    firstRunApp()
  }
  
  // appdelegate 에서 넘어오는 uuid값의 유무 확인 후 nil이면 present
  private func firstRunApp() {
    guard let myUUID = myUUID else { return }
    shared.getAdminData(uuid: myUUID)
  }
  
  private func setupMainView() {
    view.addSubview(mainView)
    let guide = view.safeAreaLayoutGuide
    mainView.translatesAutoresizingMaskIntoConstraints = false
    mainView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    mainView.widthAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
    mainView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.3).isActive = true
  }
  
  private func alertController() {
    let alert = UIAlertController(title: "설정", message: "설정하기", preferredStyle: .actionSheet)
    let addressChange = UIAlertAction(title: "집주소 변경", style: .default) { _ in
      print("addressChange")
    }
    let pushAlarm = UIAlertAction(title: "푸시 알림 설정 [예]", style: .default) { _ in
      print("pushAlarm")
    }
    let cancel = UIAlertAction(title: "취소", style: .cancel)
    
    alert.addAction(addressChange)
    alert.addAction(pushAlarm)
    alert.addAction(cancel)
    present(alert, animated: true)
  }
}


extension MainVC: MainViewDelegate {
  //attendButton 누를 시 CheckVC로 이동
  func attendCheck() {
    print("didTapAttendButtonDelegate")
    let tabBarController = UITabBarController()
    checkVC.tabBarItem = UITabBarItem(title: "오늘", image: nil, selectedImage: nil)
    detailCheckVC.tabBarItem = UITabBarItem(title: "전체", image: nil, selectedImage: nil)
    adminVC.tabBarItem = UITabBarItem(title: "관리자", image: nil, selectedImage: nil)
    tabBarController.viewControllers = [checkVC, detailCheckVC, adminVC]
    present(tabBarController, animated: true)
  }
  
  //settingButton 누를 시 action Sheet
  func setting() {
    print("didTapSettingButtonDelegate")
    alertController()
    
  }
  
}
