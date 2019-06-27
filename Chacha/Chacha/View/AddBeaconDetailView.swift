//
//  AddBeaconDetailView.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/26.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

protocol AddBeaconDetailViewDelegate: class {
  func submit(name: String, location: String)
  func cancel()
}

final class AddBeaconDetailView: UIView {
  
  var delegate: AddBeaconDetailViewDelegate?
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "NAME"
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  private let locationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Location"
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  private let nameTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.placeholder = " plz input name "
    tf.font = UIFont.boldSystemFont(ofSize: 20)
    tf.layer.borderWidth = 1
    tf.addTarget(self, action: #selector(keyboardDown(_:)), for: .editingDidEndOnExit)
    return tf
  }()
  
  private let locationTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.placeholder = " plz input location "
    tf.font = UIFont.boldSystemFont(ofSize: 20)
    tf.layer.borderWidth = 1
    tf.addTarget(self, action: #selector(keyboardDown(_:)), for: .editingDidEndOnExit)
    return tf
  }()
  
  private let cancelBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("cancel", for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    btn.addTarget(self, action: #selector(didTapcancelBtn(_:)), for: .touchUpInside)
    btn.layer.borderWidth = 1
    return btn
  }()
  
  private let submitBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("submit", for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    btn.addTarget(self, action: #selector(didTapsubmitBtn(_:)), for: .touchUpInside)
    btn.layer.borderWidth = 1
    return btn
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .lightGray
    self.alpha = 0.8
    addSubviews()
  }
  
  // submit 하기전 textfield들 값 확인
  @objc private func didTapsubmitBtn(_ sender: UIButton) {
    guard nameTextField.text != "", locationTextField.text != "" else {
      // alert 설정으로 바꾸던가 말던가 
      print("textField 값 비었다.")
      return }
    delegate?.submit(name: nameTextField.text!, location: locationTextField.text!)
  }
  
  @objc private func didTapcancelBtn(_ sender: UIButton) {
    delegate?.cancel()
  }
  
  // 키보드 내리기, 노티로 해도 되지만 기억이 잘안나...
  @objc private func keyboardDown(_ sender: UITextField) {
    resignFirstResponder()
  }
  
  private func addSubviews() {
    let views = [submitBtn, cancelBtn, locationTextField, nameTextField, locationLabel, nameLabel]
    views.forEach { addSubview($0) }
  }
  
  // 말그대로
  func reset() {
    nameTextField.text = ""
    locationTextField.text = ""
  }
  
  // 알지?
  override func layoutSubviews() {
    super.layoutSubviews()
    let padding: CGFloat = 20
    
    nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
    nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    
    nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding).isActive = true
    nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    
    locationLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding).isActive = true
    locationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    
    locationTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: padding).isActive = true
    locationTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    
    cancelBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
    cancelBtn.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -padding).isActive = true
    cancelBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    cancelBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
    
    submitBtn.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: padding).isActive = true
    submitBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
    submitBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    submitBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
