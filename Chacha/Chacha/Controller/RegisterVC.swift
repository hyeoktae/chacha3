//
//  RegisterVC.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/25.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
  
  var myUUID: String?
  let shared = Firebase.shared
  
  let registerView: RegisterView = {
    let view = RegisterView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    registerView.delegate = self
    setupRegisterView()
  }
  
  private func setupRegisterView() {
    view.addSubview(registerView)
    
    let guide = view.safeAreaLayoutGuide
    registerView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    registerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    registerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    registerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
  
  private func alert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "확인", style: .default)
    let cancelAction = UIAlertAction(title: "취소", style: .destructive)
    
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    
    present(alertController, animated: true)
  }
  
}

extension RegisterVC: RegisterViewDelegate {
  func downKeyboard() {
    resignFirstResponder()
  }
  
  // student 등록 / enroll btn 클릭
  func registerStudent() {
    
    if registerView.nameTextField.text!.isEmpty {
      // nameTextField 비어 있을 경우
      alert(title: "이름을 입력해주세요.", message: "")
    } else if registerView.schoolTextField.text!.isEmpty {
      // schoolTextField 비어 있을 경우
      alert(title: "스쿨을 입력해주세요.", message: "")
    } else if registerView.addressTextField.text!.isEmpty {
      // addressTextField 비어 있을 경우
      alert(title: "주소를 입력해주세요.", message: "")
    } else {
      myUUID = UUID.init().uuidString
      
      UserDefaults.standard.set(myUUID, forKey: "uuid")
      
      let uuid = UserDefaults.standard.string(forKey: "uuid")!
      let name = registerView.nameTextField.text!
      let address = registerView.addressTextField.text
      let school = registerView.schoolTextField.text!
      
      UserDefaults.standard.set(name, forKey: "name")
      UserDefaults.standard.set(school, forKey: "school")
      
      shared.addStudent(name: name, uuid: uuid, address: address, school: school)
      dismiss(animated: true, completion: nil)
    }
  }
}
