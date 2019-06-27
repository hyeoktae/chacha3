//
//  IBeacon.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/25.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation
import CoreLocation
import CoreBluetooth

struct beaconInfo {
  var uuid: String
  var name: String
  var location: String
}

// beacon에 대한 data
final class IBeacon {
  static let shared = IBeacon()
  
  // 에휴 상황에 따라 쓰는 변수가 달라서 어쩔수없긔
  var nearBeacons: [CLBeacon]?
  var newBeacons = [CLBeacon]()
  var downloadBeacons = [beaconInfo]()
  var uploadBeacons = [beaconInfo]()
  
  // 다운로드 한 비콘과 근처의 비콘을 비교해서 등록안된 비콘만 찾아서 사용자에게 알려줌
  func compareBeacons() {
    
    newBeacons = []
    guard nearBeacons != nil else { return }
    guard !downloadBeacons.isEmpty else {
      newBeacons = nearBeacons!
      return
    }
    
    // 이부분이 좀 많이 심각하게 오래걸렸음
    for nearBeacon in nearBeacons! {
      var count = 0
      for downloadBeacon in downloadBeacons {
        if nearBeacon.proximityUUID.uuidString == downloadBeacon.uuid {
          count += 1
        }
      }
      if count == 0 {
        newBeacons.append(nearBeacon)
      }
    }
  }
  
  // 업데이트 하기 전 기존 beacons 와 add하는 beacon 의 합체
  func readyToUpdateBeacon(index: Int?, name: String, location: String) {
    guard let idx = index else { return }
    
    self.uploadBeacons = self.downloadBeacons
    let newUUID = newBeacons[idx].proximityUUID.uuidString
    
    uploadBeacons.append(beaconInfo(uuid: newUUID, name: name, location: location))
    
  }
  
}

extension AppDelegate: CLLocationManagerDelegate {
  
  // 위치정보 허용 권한 체크
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    print("check location state")
    if status == .authorizedAlways {
      monitorBeacons()
    } else {
      // 현재 위치가 항상 허용이 아니라면 설정으로 이동해서 항상허용으로 바꾸게 유도해야함
      makeAlert {
        self.moveToSetting()
      }
    }
  }
  
  
  
  // 비콘 모니터링 시작
  func monitorBeacons() {
    if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
      //      print("monitorBeacons Run before", beaconRegion)
      beaconRegion.notifyEntryStateOnDisplay = true
      beaconRegion.notifyOnExit = true
      beaconRegion.notifyOnEntry = true
      locationManager.startMonitoring(for: beaconRegion)
      //      print("monitorBeacons Run", beaconRegion)
    } else {
      // 현재 디바이스가 비콘을 모니터링 불가능할 경우
      print("CLLoacation Monitoring is unavailable")
    }
  }
  
  // 비콘 탐지중
  func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
    print("비콘 탐지 시작")
    guard beaconRegion.proximityUUID == uuid else { return }
    
    if state == .inside {
      // 비콘의 탐지 범위 내
      locationManager.startRangingBeacons(in: beaconRegion)
      // 아래에 출첵 시키면 됨
      guard (UserDefaults.standard.string(forKey: "uuid") != nil) else { return }
      todayCheck.shared.checkState() {
        print("출첵 성공")
      }
    } else if state == .outside {
      // 비콘의 탐지 범위 외
      locationManager.stopRangingBeacons(in: beaconRegion)
    } else if state == .unknown {
      // 알수 없는 오류
      print("Now unknown of Region")
    }
  }
  
  // 비콘 거리 감지하는
  func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    IBeacon.shared.nearBeacons = beacons
//    print("beacon 탐지중")
    
    //    print("@@@비콘의 범위 탐지함@@@", IBeacon.shared.nearBeacons)
    //    for beacon in beacons {
    //      if beacon.proximityUUID == uuid {
    //        switch beacon.proximity {
    //        case .immediate:
    //          // 매우 근접
    //          ()
    //        case .near:
    //          // 근접
    //          ()
    //        case .far:
    //          // 멀어짐
    //          ()
    //        case .unknown:
    //          // 탐지 불가
    //          ()
    //        @unknown default:
    //          // 예상외 오류
    //          ()
    //        }
    //      }
    //    }
  }
  
  
}
