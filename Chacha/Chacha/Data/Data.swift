//
//  Data.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/25.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation

// network 오류 등등 
enum fail: Error {
  case downloadFail, networkError, noData, uploadFail
}

enum stateOfCheck: String {
  case check, late, none
}

final class todayCheck {
  static let shared = todayCheck()
  
  private var stateArr = [stateOfCheck]()
  private var todayArr = [String]()
  
  func checkState(completion: @escaping () -> ()) {
    let result = checkTime()
    checkToday(result.1)
    stateArr.append(result.0)
    todayArr.append(result.1)
    
    guard let uuid = UserDefaults.standard.string(forKey: "uuid"),
      let name = UserDefaults.standard.string(forKey: "name"),
      let school = UserDefaults.standard.string(forKey: "school") else {
        return
    }
    
    Firebase.shared.registerCheck(uuid: uuid, name: name, school: school, state: stateArr.first!, today: todayArr.first!) {
      completion()
    }
  }
  
  private func checkToday(_ today: String) {
    guard !todayArr.isEmpty else { return }
    guard todayArr.last! == today else { return }
    todayArr = []
  }
  
  private func checkTime() -> (stateOfCheck, String) {
    let timeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    // 출근해야하는 시간
    let safeDateString: String = "10:00:00"
    
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    timeFormatter.dateFormat = "HH:mm:ss"
//    timeFormatter.timeZone = TimeZone(identifier: "UTC")
    
    let today: String = dateFormatter.string(from: Date())
    let nowTime: String = timeFormatter.string(from: Date())
    
    print("기준 시간: ", safeDateString)
    print("지금 시간: ", nowTime)
    
    if nowTime <= safeDateString {
      print("출석")
      return (.check, today)
    } else if nowTime > safeDateString {
      print("지각")
      return (.late, today)
    } else {
      print("결석")
      return (.none, today)
    }
  }
}

//var testBeaconData = [beaconInfo]()
//
//func testData() {
//  for i in 0...5 {
//  testBeaconData.append(beaconInfo(uuid: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825", name: "name\(i)", location: "location\(i)"))
//  }
//}
