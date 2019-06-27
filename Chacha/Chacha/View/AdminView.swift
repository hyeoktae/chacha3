//
//  AdminView.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

protocol AdminViewDelegate: class {
  //스쿨관리 버튼 누를시 실행할 메소드
  func getAdminTableView()
  func moveToAddBeaconVC()
}


class AdminView: UIView {
  
  var delegate: AdminViewDelegate?
  
  // MARK: - Properties
  private let schoolButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .red
    button.setTitle("스쿨관리", for: .normal)
    button.addTarget(self, action: #selector(didTapAdminButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let studentButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .orange
    button.setTitle("학생관리", for: .normal)
    button.addTarget(self, action: #selector(didTapAdminButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let adminButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .yellow
    button.setTitle("관리자관리", for: .normal)
    button.addTarget(self, action: #selector(didTapAdminButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let beaconButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .green
    button.setTitle("비콘관리", for: .normal)
    button.addTarget(self, action: #selector(didTapBeaconButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupAdminView()
    
  }
  private func setupAdminView() {
    addSubview(schoolButton)
    addSubview(studentButton)
    addSubview(adminButton)
    addSubview(beaconButton)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    schoolButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
    schoolButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    schoolButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    schoolButton.bottomAnchor.constraint(equalTo: studentButton.topAnchor).isActive = true
    
    studentButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    studentButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    studentButton.bottomAnchor.constraint(equalTo: adminButton.topAnchor).isActive = true
    studentButton.heightAnchor.constraint(equalTo: schoolButton.heightAnchor).isActive = true
    
    adminButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    adminButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    adminButton.bottomAnchor.constraint(equalTo: beaconButton.topAnchor).isActive = true
    adminButton.heightAnchor.constraint(equalTo: schoolButton.heightAnchor).isActive = true
    
    beaconButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    beaconButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    beaconButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    beaconButton.heightAnchor.constraint(equalTo: schoolButton.heightAnchor).isActive = true
  
  }
  
  @objc private func didTapAdminButton(_ sender: UIButton) {
    delegate?.getAdminTableView()
  }
  
  @objc private func didTapBeaconButton(_ sender: UIButton) {
    delegate?.moveToAddBeaconVC()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
