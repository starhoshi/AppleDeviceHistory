//
//  DetailViewController.swift
//  AppleDeviceHistory
//
//  Created by Kensuke Hoshikawa on 2017/04/23.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
