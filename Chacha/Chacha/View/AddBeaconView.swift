//
//  AddBeaconView.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

protocol AddBeaconViewDelegate: class {
  func selectedCell(_ indexRow: Int)
  func reload()
  func popVC()
}

class AddBeaconView: UIView {
  
  var delegate: AddBeaconViewDelegate?
  
  private lazy var beaconTblView: UITableView = {
    let tbl = UITableView()
    tbl.translatesAutoresizingMaskIntoConstraints = false
    tbl.register(UITableViewCell.self, forCellReuseIdentifier: "beaconCell")
    tbl.dataSource = self
    tbl.delegate = self
    return tbl
  }()
  
  private let reloadBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("새로고침", for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    btn.addTarget(self, action: #selector(didTapReloadBtn(_:)), for: .touchUpInside)
    btn.layer.borderWidth = 1
    return btn
  }()
  
  private let popBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("뒤로가기", for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    btn.addTarget(self, action: #selector(didTapPopBtn(_:)), for: .touchUpInside)
    btn.layer.borderWidth = 1
    return btn
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews()
  }
  
  private func addSubviews() {
    let views = [beaconTblView, reloadBtn, popBtn]
    views.forEach { addSubview($0) }
  }
  
  // 나도 이걸 왜 구지 넘기는지모르겠당
  @objc private func didTapReloadBtn(_ sender: UIButton) {
    delegate?.reload()
  }
  
  // dismiss 할라고
  @objc private func didTapPopBtn(_ sender: UIButton) {
    delegate?.popVC()
  }
  
  // 진짜 이거 왜했지?
  func tblViewReload() {
    beaconTblView.reloadData()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let guide = self.safeAreaLayoutGuide
    
    reloadBtn.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    reloadBtn.leadingAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    
    popBtn.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    popBtn.trailingAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    
    beaconTblView.topAnchor.constraint(equalTo: reloadBtn.bottomAnchor).isActive = true
    beaconTblView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    beaconTblView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    beaconTblView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension AddBeaconView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return IBeacon.shared.newBeacons.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "beaconCell", for: indexPath)
    cell.textLabel?.text = IBeacon.shared.newBeacons[indexPath.row].proximityUUID.uuidString
    cell.detailTextLabel?.text = String(describing: IBeacon.shared.newBeacons[indexPath.row].proximity)
    return cell
  }
  
}

extension AddBeaconView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.selectedCell(indexPath.row)
  }
}
