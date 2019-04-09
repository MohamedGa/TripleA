//
//  personCell.swift
//  TripleA
//
//  Created by Mohammed Gamal on 2/3/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit

class personCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var imagview: UIView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var companyId: UILabel!
    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var paidImage: UIImageView!
    var service_list = [companyServices]()
     var refresher : UIRefreshControl!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
    
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        companyImage.layer.borderWidth = 2
        companyImage.layer.borderColor = UIColor.red.cgColor
        companyId.isHidden = true
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (personCell.getCompanyServices), for: UIControlEvents.valueChanged)
        servicesCollectionView.addSubview(refresher)
      
       
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
     func getCompanyServices() {


        let def = UserDefaults.standard
        let c_id = def.object(forKey: "c_id")
        API.getCompanyServices (c_id: c_id! as! Int ) {(error: Error?, service_list:[companyServices]?) in
            if let service_list = service_list {
                self.service_list = service_list

                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }

                self.servicesCollectionView.reloadData()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Set the number of items in your collection view.
        return service_list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Access
        let cell = servicesCollectionView.dequeueReusableCell(withReuseIdentifier: "servicesCell", for: indexPath) as! servicesCell
        
        let strin = self.service_list[indexPath.row].s_image
        
        cell.serviceImage.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/pro_images/\(strin)", indicatorColor: .gray, errorImage: UIImage(named: "LOGO")!, imageView:  cell.serviceImage)
        
        
        return cell
    }
    
}


  
