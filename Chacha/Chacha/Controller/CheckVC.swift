//
//  CheckVC.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class CheckVC: UIViewController {

  let checkView = CheckView()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      setupCheckView()
    }
  
  private func setupCheckView() {
    view.addSubview(checkView)
    
    let guide = view.safeAreaLayoutGuide
    checkView.translatesAutoresizingMaskIntoConstraints = false
    checkView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    checkView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    checkView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.8).isActive = true
    checkView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.3).isActive = true
  }
}
