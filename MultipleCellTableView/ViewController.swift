//
//  ViewController.swift
//  CellInCell
//
//  Created by Chung Sama on 9/24/17.
//  Copyright © 2017 Chung Sama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        DataServices.shared.loadData(json: "ServerData")
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(disPlayData), name: NotificationKey.update, object: nil)
    }
    
    func disPlayData() {
        tableView.reloadData()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    enum CellType: Int {
        case spaceTopSection
        case title
        case address
        case salary
        case requirement
        case spaceBottomSection
        case numberOfRowsInSection
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataServices.shared.jobs.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.numberOfRowsInSection.rawValue
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case CellType.spaceTopSection.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellHeader", for: indexPath)
            return cell
        case CellType.title.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellTitle", for: indexPath) as! TitleCell
            cell.nameLable?.text = "Job Title:\n    \(String(describing: DataServices.shared.jobs[indexPath.section].jobTitle))"
            return cell
        case CellType.address.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellAddress", for: indexPath) as! AddressCell
            cell.nameLable?.text = "Address:\n    \(String(describing: DataServices.shared.jobs[indexPath.section].address))"
            return cell
        case CellType.salary.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellSalary", for: indexPath) as! SalaryCell
            cell.nameLable?.text = "Salary:\n    \(String(describing: DataServices.shared.jobs[indexPath.section].salary))"
            return cell
        case CellType.requirement.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellRequirement", for: indexPath) as! RequirementCell
            cell.nameLable?.text = "Requirement:\n    \(String(describing: DataServices.shared.jobs[indexPath.section].requirement))"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellFooter", for: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case CellType.spaceTopSection.rawValue:
            return 15
        case CellType.spaceBottomSection.rawValue:
            return 30
        case CellType.requirement.rawValue:
            let heightDefault: CGFloat = 50
            let SCREEN_WIDTH = UIScreen.main.bounds.size.width
            let widthString = DataServices.shared.jobs[indexPath.section].requirement.widthOfString(usingFont: UIFont.systemFont(ofSize: 17))
            var numberLines: Int = Int(widthString/(SCREEN_WIDTH - 45) + 1)
            if numberLines == 1 {
                numberLines += 1
            }
            let heightOneLine = DataServices.shared.jobs[indexPath.section].requirement.heightOfString(usingFont: UIFont.systemFont(ofSize: 17))
            let heightString: CGFloat = CGFloat(numberLines) * heightOneLine
            print("Height row \(indexPath.row) in section \(indexPath.section) :\(heightString)")
            return heightString + heightDefault
        default:
            return 50
        }
    }
}
