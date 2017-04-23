//
//  ViewController.swift
//  AppleDeviceHistory
//
//  Created by Kensuke Hoshikawa on 2017/04/23.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import UIKit
import RxCocoa
import APIKit
import SVProgressHUD

final class ListViewController: UIViewController {
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    var deviceList: [ListSection] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        navigationItem.title = "Apple Device History"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(R.nib.listTableViewCell(), forCellReuseIdentifier: R.nib.listTableViewCell.name)
        loadAppleDeviceList()
    }

    private func loadAppleDeviceList() {
        SVProgressHUD.show()
        let request = AppleDeviceAPI.AppleDeviceListRequest()
        Session.shared.send(request) { [weak self] result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let list):
                self?.deviceList = [
                    ListSection(title: "iPhone", items: list.iphone),
                    ListSection(title: "iPad", items: list.ipad),
                    ListSection(title: "iPad Mini", items: list.ipadMini),
                    ListSection(title: "iPod Touch", items: list.ipodTouch)
                ]
            case .failure(let e):
                log?.warning(e)
            }
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log?.info(indexPath)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return deviceList[section].title
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return deviceList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.listTableViewCell.name) as! ListTableViewCell
        cell.setUp(appleDevice: deviceList[indexPath.section].items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

struct ListSection {
    let title: String
    let items: [AppleDevice]
}
