//
//  ViewController.swift
//  AppleDeviceHistory
//
//  Created by Kensuke Hoshikawa on 2017/04/23.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import UIKit
import APIKit
import SVProgressHUD
import RxCocoa
import RxSwift

final class ListViewController: UIViewController {
    let disposeBag = DisposeBag()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    private func loadAppleDeviceList() {
        SVProgressHUD.show()
        let request = AppleDeviceAPI.AppleDeviceListRequest()
        Session.shared.send(request) { [weak self] result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let list):
                self?.view = self?.tableView
                self?.deviceList = [
                    ListSection(title: "iPhone", items: list.iphone),
                    ListSection(title: "iPad", items: list.ipad),
                    ListSection(title: "iPad Mini", items: list.ipadMini),
                    ListSection(title: "iPod Touch", items: list.ipodTouch)
                ]
            case .failure(let e):
                log?.warning(e)
                self?.showError()
            }
        }
    }

    private func showError() {
        let button = UIButton(type: .system)
        button.setTitle("Sorry,\n An error has occurred.\n\nTap to reload.", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        let errorView = UIView()
        errorView.backgroundColor = .white
        errorView.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        button.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.loadAppleDeviceList()
        }).disposed(by: disposeBag)
        view = errorView
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log?.info(indexPath)
        let detailViewController = DetailViewController.instantiate()
        detailViewController.appleDevice = deviceList[indexPath.section].items[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
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
