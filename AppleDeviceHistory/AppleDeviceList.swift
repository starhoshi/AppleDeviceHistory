//
//  AppleDeviceList.swift
//  AppleDeviceHistory
//
//  Created by Kensuke Hoshikawa on 2017/04/23.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation
import ObjectMapper

final class AppleDeviceList: ImmutableMappable {
    let iphone: [AppleDevice]
    let ipad: [AppleDevice]
    let ipadMini: [AppleDevice]
    let ipodTouch: [AppleDevice]

    init(map: Map) throws {
        iphone = try map.value("iphone")
        ipad = try map.value("ipad")
        ipadMini = try map.value("ipad_mini")
        ipodTouch = try map.value("ipod_touch")
    }
}
