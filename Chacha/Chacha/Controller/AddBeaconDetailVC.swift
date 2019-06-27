//
//  AddBeaconDetailVC.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/26.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

final class AddBeaconDetailVC: UIViewController {
  
  // AddBeaconView 의 tblview 셀 클릭시 indexpath.row값
  var indexRow: Int?
  
  private let addBeaconDetailView: AddBeaconDetailView = {
    let view = AddBeaconDetailView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addBeaconDetailView.delegate = self
    view.addSubview(addBeaconDetailView)
    setupAutolayout()
  }
  
  
  private func setupAutolayout() {
    let guide = view.safeAreaLayoutGuide
    
    addBeaconDetailView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    addBeaconDetailView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    addBeaconDetailView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.5).isActive = true
    addBeaconDetailView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.5).isActive = true
  }
  
}


extension AddBeaconDetailVC: AddBeaconDetailViewDelegate {
  func submit(name: String, location: String) {
    
    // 찾아가면 주석있음
    IBeacon.shared.readyToUpdateBeacon(index: indexRow, name: name, location: location)
    // 이것도
    Firebase.shared.addBeacons(IBeacon.shared.uploadBeacons) {
      switch $0 {
      case .failure(let err):
        print("error: ", err.localizedDescription)
      case .success(_):
        DispatchQueue.main.async {
          print("success")
          self.presentingViewController?.dismiss(animated: true)
        }
      }
      // 이건 보면 알지 이름만
      self.addBeaconDetailView.reset()
    }
    
  }
  
  func cancel() {
    addBeaconDetailView.reset()
    presentingViewController?.dismiss(animated: true)
    
//    Firebase.shared.getBeacons {
//      switch $0 {
//      case .failure(let err):
//        print("error: ", err.localizedDescription)
//      case .success(_):
//        DispatchQueue.main.async {
//          print("success")
//          self.presentingViewController?.dismiss(animated: true)
//        }
//      }
//    }
    
  }
  
  
}
