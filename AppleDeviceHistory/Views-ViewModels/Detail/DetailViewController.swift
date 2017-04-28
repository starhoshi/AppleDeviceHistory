//
//  DetailViewController.swift
//  AppleDeviceHistory
//
//  Created by Kensuke Hoshikawa on 2017/04/23.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import UIKit
import APIKit
import SVProgressHUD

final class DetailViewController: UITableViewController, Storyboardable {
    let noData = "No Data"
    var appleDevice: AppleDevice!

    @IBOutlet weak var thumbnail: UIImageView!

    // INFORMATION
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var simCard: UILabel!
    @IBOutlet weak var ram: UILabel!
    @IBOutlet weak var connector: UILabel!
    @IBOutlet weak var color: UILabel!

    // EXTRA
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var battery: UILabel!
    @IBOutlet weak var voiceAssistant: UILabel!
    @IBOutlet weak var rearCamera: UILabel!
    @IBOutlet weak var frontCamera: UILabel!

    // DATASOURCE
    @IBOutlet weak var dataSource: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = appleDevice.name
        loadAppleDeviceList()
    }

    private func loadAppleDeviceList() {
        SVProgressHUD.show()
        let request = AppleDeviceAPI.TargetDeviceRequest(targetPath: appleDevice.path!)
        Session.shared.send(request) { [weak self] result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let appleDevice):
                self?.appleDevice = appleDevice
                self?.setUp()
            case .failure(let e):
                log?.warning(e)
                self?.showError()
            }
        }
    }

    private func setUp() {
        thumbnail.kf.setImage(with: appleDevice.image)
        thumbnail.contentMode = .scaleAspectFit
        model.text = appleDevice.name
        releaseDate.text = appleDevice.releaseDate
        simCard.text = appleDevice.simCard ?? noData
        ram.text = appleDevice.ram ?? noData
        connector.text = appleDevice.connector ?? noData
        color.text = appleDevice.color?.joined(separator: "\n") ?? noData
        weight.text = appleDevice.weight ?? noData
        size.text = appleDevice.size ?? noData
        display.text = appleDevice.display ?? noData
        battery.text = appleDevice.battery ?? noData
        voiceAssistant.text = appleDevice.voiceAssistant ?? noData
        rearCamera.text = appleDevice.rearCamera ?? noData
        frontCamera.text = appleDevice.frontCamera ?? noData
        dataSource.text = appleDevice.url.absoluteString
        tableView.reloadData()
    }

    private func showError() {
        let label = UILabel()
        label.text = "Sorry,\n An error has occurred."
        label.numberOfLines = 2
        label.textAlignment = .center
        let errorView = UIView()
        errorView.backgroundColor = .white
        errorView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] _ in
            self?.view = errorView
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if UIApplication.shared.canOpenURL(appleDevice.url) {
            UIApplication.shared.openURL(appleDevice.url)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
