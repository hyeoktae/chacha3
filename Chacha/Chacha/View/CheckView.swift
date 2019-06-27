//
//  CheckView.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class CheckView: UIView {
  
  // MARK: - Properties
  
  private let stateImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .yellow
    imageView.image = UIImage(named: "dismiss")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let stateLabel: UILabel = {
    let label = UILabel()
    label.text = "출석처리 되었습니다."
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupCheckView()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    stateImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stateImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    stateImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    stateImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    stateLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    stateLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    stateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    stateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
  }
  
  private func setupCheckView() {
    addSubview(stateImageView)
    addSubview(stateLabel)
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
