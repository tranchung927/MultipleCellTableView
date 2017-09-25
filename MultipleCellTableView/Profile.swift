//
//  Profile.swift
//  CellInCell
//
//  Created by Chung Sama on 9/24/17.
//  Copyright © 2017 Chung Sama. All rights reserved.
//

import Foundation

typealias JSON = Dictionary<AnyHashable,Any>

struct DataJob {
    var jobs: [Profile] = []
    init?(json: JSON) {
        guard let datas = json["job"] as? [JSON] else {return}
        for data in datas {
            if let job = Profile(json: data) {
                jobs.append(job)
            }
        }
    }
}

class Profile {
    
    var jobTitle: String = ""
    var address: String = ""
    var salary: String = ""
    var requirement: String = ""
    
    init?(json: JSON) {
//        guard let job = json["job"] as? JSON else {return}
        guard let jobTitle = json["jobTitle"] as? String else {return}
        guard let address = json["address"] as? String else {return}
        guard let salary = json["salary"] as? String else {return}
        guard let requirement = json["requirement"] as? String else {return}
        
        self.jobTitle = jobTitle
        self.address = address
        self.salary = salary
        self.requirement = requirement
    }
}
