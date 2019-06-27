//
//  DetailCheckVC.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class DetailCheckVC: UIViewController {

  let label = UILabel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.addSubview(label)
      label.text = "DetailCheckVC"
      label.frame = view.frame

    }

}
