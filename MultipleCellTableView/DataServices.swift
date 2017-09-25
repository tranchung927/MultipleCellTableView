//
//  DataServices.swift
//  CellInCell
//
//  Created by Chung Sama on 9/24/17.
//  Copyright © 2017 Chung Sama. All rights reserved.
//

import UIKit

class DataServices {
    
    static let shared: DataServices = DataServices()
    
    private var job: DataJob?
    
    private var _jobs: [Profile]?
    
    var jobs: [Profile] {
        get {
            if _jobs == nil {
                getJobs()
            }
            return _jobs ?? []
        }
        set {
            _jobs = newValue
        }
    }
    
    func getJobs() {
        if let jobData = job?.jobs {
            _jobs = jobData
        }
    }
    
    func loadData(json: String) {
        let url = Bundle.main.url(forResource: json, withExtension: "json")
        let urlRequest = URLRequest(url: url!)
        makeDataTaskRequest(request: urlRequest) {[unowned self] jobData in
            self.job = DataJob(json: jobData)
            NotificationCenter.default.post(name: NotificationKey.update, object: nil)
        }
    }
    private func makeDataTaskRequest(request: URLRequest, completedBlock: @escaping (JSON) -> Void ) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let jsonObject =  try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) else {
                return
            }
            guard let json = jsonObject as? JSON else {
                return
            }
            DispatchQueue.main.async {
                completedBlock(json)
            }
        }
        task.resume()
    }
    
}
struct NotificationKey {
    static let update = Notification.Name.init("update")
}
