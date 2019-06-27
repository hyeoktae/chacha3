//
//  AddBeaconVC.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/26.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

final class AddBeaconVC: UIViewController {
  
  private let addBeaconView = AddBeaconView(frame: UIScreen.main.bounds)
  private let addBeaconDetailVC = AddBeaconDetailVC()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getBeacons()
    addBeaconView.delegate = self
    view.addSubview(addBeaconView)
  }
  
}

extension AddBeaconVC: AddBeaconViewDelegate {
  func popVC() {
    dismiss(animated: true)
  }
  
  func reload() {
    getBeacons()
  }
  
  private func getBeacons() {
    // 찾아가면 주석있음
    Firebase.shared.getBeacons {
      switch $0 {
      case .failure(let err):
        IBeacon.shared.downloadBeacons = []
        print(err.localizedDescription)
      case .success(_):
        break
      }
      // 이것도 주석달아둠
      IBeacon.shared.compareBeacons()
      DispatchQueue.main.async {
        // 이름만 봐도 딱
        self.addBeaconView.tblViewReload()
      }
    }
  }
  
  func selectedCell(_ indexRow: Int) {
    //    print("click")
    // 셀의 인덱스 로우 값 토스
    addBeaconDetailVC.indexRow = indexRow
    // 뒤에 보이면서 띄우기 분명 배운거임
    addBeaconDetailVC.modalPresentationStyle = .overCurrentContext
    present(addBeaconDetailVC, animated: true)
  }
}
