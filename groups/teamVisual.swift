//
//  teamVisual.swift
//  TripleA
//
//  Created by apple on 1/29/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class teamVisual: UIViewController, UITableViewDataSource,UITableViewDelegate,IndicatorInfoProvider {
    var refresher : UIRefreshControl!
    var group_list = [groups]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleRefresh()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (teamVisual.handleRefresh), for: UIControlEvents.valueChanged)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.addSubview(refresher)
        
        // Do any additional setup after loading the view.
    }
    @objc private func handleRefresh() {
        let s_id = helper.getS_ID()
        API.getGroups (s_id: s_id!) {(error: Error?, group_list:[groups]?) in
            if let group_list = group_list {
                self.group_list = group_list
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                self.tableView.reloadData()
            }
        }
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group_list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell") as! teamCell
        
        cell.companyName.text = group_list[indexPath.row].c_name
        let strin = self.group_list[indexPath.row].c_image
        
        cell.companyImage.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/company_images/\(strin)", indicatorColor: .gray, errorImage: UIImage(named: "LOGO")!, imageView: cell.companyImage)
      
        let coverPhoto = self.group_list[indexPath.row].c_coverimage
        
        cell.coverPhoto.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/company_coverimages/\(coverPhoto)", indicatorColor: .gray, errorImage: UIImage(named: "overlay")!, imageView: cell.coverPhoto)
        
       
       cell.companyID.text = String(group_list[indexPath.row].c_id)
        let c_id = Int(group_list[indexPath.row].c_id)
        let def = UserDefaults.standard
        def.setValue(c_id, forKey: "c_id")
        def.synchronize()
        let success = self.group_list[indexPath.row].c_guaranteed
        if success == "1" {
            cell.paidImage.isHidden = false
        }
        else
        {
           cell.paidImage.isHidden = true
        }
        
        cell.getCompanyServices()
        return cell //4.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        
        let currentCell = tableView.cellForRow(at: indexPath!) as! teamCell
        let c_id = Int(currentCell.companyID.text!)
        let def = UserDefaults.standard
        def.setValue(c_id, forKey: "c_id")
        def.synchronize()
        
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "مجموعات",image: UIImage(named: "persons"))
    }
    
}
