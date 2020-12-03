//
//  Avatar.swift
//  VinhomeApp
//
//  Created by NguyenVu on 30/11/2020.
//

import Foundation
import SwiftyJSON

class Avatar {

    let contentType: String?
    let extensionField: String?
    let name: String?
    let size: String?
    let path: String?

    init?(_ json: JSON) {
        contentType = json["contentType"].stringValue
        extensionField = json["extension"].stringValue
        name = json["name"].stringValue
        size = json["size"].stringValue
        path = json["path"].stringValue
    }

}
