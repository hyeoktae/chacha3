//
//  MainView.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/25.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

protocol MainViewDelegate: class {
  //출결현황 버튼 누를 시 실행할 메소드
  func attendCheck()
  
  //설정 버튼 누를 시 실행할 메소드
  func setting()
}


final class MainView: UIView {
  
  var delegate: MainViewDelegate?
  
  // MARK: - Properties
  
  private let attendButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("출결현황", for: .normal)
    button.backgroundColor = .red
    button.tintColor = .white
    button.addTarget(self, action: #selector(didTapAttendButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let settingButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("설정", for: .normal)
    button.backgroundColor = .blue
    button.tintColor = .white
    button.addTarget(self, action: #selector(didTapSettingButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupMainView()
    
  }
  
  private func setupMainView() {
    addSubview(attendButton)
    addSubview(settingButton)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    attendButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
    attendButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    attendButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor).isActive = true
    attendButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    attendButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
    
    settingButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
    settingButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    settingButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    settingButton.widthAnchor.constraint(equalTo: attendButton.widthAnchor).isActive = true
  }
  
  @objc private func didTapAttendButton(_ sender: UIButton) {
    delegate?.attendCheck()
  }
  
  @objc private func didTapSettingButton(_ sender: UIButton) {
    delegate?.setting()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
