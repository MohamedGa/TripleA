//
//  personVisual.swift
//  TripleA
//
//  Created by apple on 1/29/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class personVisual:UIViewController, UITableViewDataSource,UITableViewDelegate,IndicatorInfoProvider {
    var refresher : UIRefreshControl!
    var person_list = [persons]()
    
   
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleRefresh()
        tableView.delegate=self
        tableView.dataSource=self
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (personVisual.handleRefresh), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refresher)
       
        
        
        // Do any additional setup after loading the view.
    }
    @objc private func handleRefresh() {
         let s_id = helper.getS_ID()
        API.getPersons (s_id: s_id!) {(error: Error?, person_list:[persons]?) in
            if let person_list = person_list {
                self.person_list = person_list
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person_list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") as! personCell
        
        cell.companyName.text = person_list[indexPath.row].c_name
        let strin = self.person_list[indexPath.row].c_image
        
        cell.companyImage.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/company_images/\(strin)", indicatorColor: .gray, errorImage: UIImage(named: "LOGO")!, imageView: cell.companyImage)
       
        let coverPhoto = self.person_list[indexPath.row].c_coverimage
        
        cell.coverPhoto.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/company_coverimages/\(coverPhoto)", indicatorColor: .gray, errorImage: UIImage(named: "overlay")!, imageView: cell.coverPhoto)
        
        cell.companyId.text = String(person_list[indexPath.row].c_id)
        let c_id = Int(person_list[indexPath.row].c_id)
        let def = UserDefaults.standard
        def.setValue(c_id, forKey: "c_id")
        def.synchronize()
        let success = self.person_list[indexPath.row].c_guaranteed
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
        
        let currentCell = tableView.cellForRow(at: indexPath!) as! personCell
        let c_id = Int(currentCell.companyId.text!)
        let def = UserDefaults.standard
        def.setValue(c_id, forKey: "c_id")
        def.synchronize()
        
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "افراد",image: UIImage(named: "person"))
    }
   
    
}
