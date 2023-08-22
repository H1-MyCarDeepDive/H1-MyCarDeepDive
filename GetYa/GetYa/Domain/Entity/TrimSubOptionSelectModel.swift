//
//  TrimSubOption.swift
//  GetYa
//
//  Created by 배남석 on 2023/08/21.
//

import Foundation

struct TrimSubOptionSelectModel {
    var engineID: Int
    var bodyID: Int
    var drivingSystemID: Int
    
    init(engineID: Int, bodyID: Int, drivingSystemID: Int) {
        self.engineID = engineID
        self.bodyID = bodyID
        self.drivingSystemID = drivingSystemID
    }
}
