//
//  AppleDeviceAPI.swift
//  AppleDeviceHistory
//
//  Created by Kensuke Hoshikawa on 2017/04/23.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit
import Device

final class AppleDeviceAPI {
    private init() {

    }

    struct TargetDeviceRequest: AppleDeviceRequest {
        let type: Type
        let target: Version

        init(type: Type, target: Version) {
            self.type = type
            self.target = target
        }

        // MARK: RequestType
        typealias Response = AppleDevice

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return "/api/v1/devices/\(type.appleDeviceAPIPath)/\(target.appleDeviceAPIPath).json"
        }
    }

    struct AppleDeviceListRequest: AppleDeviceRequest {
        init() {
        }

        // MARK: RequestType
        typealias Response = AppleDeviceList

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return "/api/v1/devices.json"
        }
    }
}
