//
//  companyVisual.swift
//  TripleA
//
//  Created by apple on 1/29/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import KImageView
class companyVisual: UIViewController, UITableViewDataSource,UITableViewDelegate,IndicatorInfoProvider {
    var refresher : UIRefreshControl!
    var company_list = [companies]()
    //let ms_id = 1
    
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleRefresh()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (companyVisual.handleRefresh), for: UIControlEvents.valueChanged)
tableView.delegate=self
        tableView.dataSource=self
        tableView.addSubview(refresher)
        
        // Do any additional setup after loading the view.
        
    }
    @objc private func handleRefresh() {
        let s_id = helper.getS_ID()
        API.getCompanies (s_id: s_id!) {(error: Error?, company_list:[companies]?) in
            if let company_list = company_list {
                self.company_list = company_list
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                self.tableView.reloadData()
            }
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return company_list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyVisualCell", for: indexPath) as! companyVisualCell
        cell.companyName.text = company_list[indexPath.row].c_name
        let strin = self.company_list[indexPath.row].c_image
        
        cell.companyImage.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/company_images/\(strin)", indicatorColor: .gray, errorImage: UIImage(named: "LOGO")!, imageView: cell.companyImage)
    
        cell.companyID.text = String(company_list[indexPath.row].c_id)
        let success = self.company_list[indexPath.row].c_guaranteed
        if success == "1" {
            cell.paidImage.isHidden = false
        }
        else
        {
            cell.paidImage.isHidden = true
        }
        
        return cell //4.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        
        let currentCell = tableView.cellForRow(at: indexPath!) as! companyVisualCell
        let c_id = Int(currentCell.companyID.text!)
        let def = UserDefaults.standard
        def.setValue(c_id, forKey: "c_id")
        def.synchronize()
        
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "شركات",image: UIImage(named: "copmanies"))
    }

}
