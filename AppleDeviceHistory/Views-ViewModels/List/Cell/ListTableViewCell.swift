//
//  ListTableViewCell.swift
//  AppleDeviceHistory
//
//  Created by Kensuke Hoshikawa on 2017/04/23.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var releaseDate: UILabel!

    override func prepareForReuse() {
        thumbnail.image = nil
        name.text = nil
        releaseDate.text = nil
    }

    func setUp(appleDevice: AppleDevice) {
        log?.info(appleDevice.image.absoluteString)
        thumbnail.updateConstraintsIfNeeded()
        thumbnail.kf.setImage(with: appleDevice.image,
            placeholder: nil,
            options: nil,
            progressBlock: { _ in
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            },
            completionHandler: { result in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if result.1 != nil {
                    log?.warning(result)
                }
        })
        thumbnail.contentMode = .scaleAspectFit
        name.text = appleDevice.name
        releaseDate.text = "Release Date:" + appleDevice.releaseDate
    }
}
