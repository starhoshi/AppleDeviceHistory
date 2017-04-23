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
        let targetPath: String

        init(targetPath: String) {
            self.targetPath = targetPath
        }

        // MARK: RequestType
        typealias Response = AppleDevice

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return targetPath
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
