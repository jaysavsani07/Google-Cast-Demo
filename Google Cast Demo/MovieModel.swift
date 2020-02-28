//
//  MovieModel.swift
//  Google Cast Demo
//
//  Created by Jay on 28/02/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Foundation
import SwiftyJSON


class MovieModel: NSObject {
    
    var desc: String!
    var sources: String!
    var subTitle: String!
    var thumb: String!
    var title: String!
    
    init(fromJson json: JSON) {
        desc = json["description"].stringValue
        sources = json["sources"][0].stringValue
        subTitle = json["subtitle"].stringValue
        thumb = json["thumb"].stringValue
        title = json["title"].stringValue
    }
    
}

