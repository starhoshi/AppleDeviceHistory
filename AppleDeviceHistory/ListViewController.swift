//
//  ViewController.swift
//  AppleDeviceHistory
//
//  Created by Kensuke Hoshikawa on 2017/04/23.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import UIKit
import RxCocoa

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
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        log?.info(indexPath)
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return deviceList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description())!
        return cell
    }
}

struct ListSection {
    let title: String
    let items: [AppleDevice]
}
