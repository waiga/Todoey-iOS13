//
//  Category.swift
//  Todoey
//
//  Created by 김미향 on 2022/02/15.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
