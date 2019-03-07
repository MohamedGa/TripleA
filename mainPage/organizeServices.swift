//
//  organizeServices.swift
//  TripleA
//
//  Created by apple on 1/26/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class organizeServices:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,IndicatorInfoProvider {
   
    @IBOutlet weak var orgnizeServices: UICollectionView!
    var imageFiles = [String]()
    var images = [UIImage]()
    var labelFiles = [String]()
    var refresher : UIRefreshControl!
    var location_list = [subServices]()
    let ms_id = 2
    
    override func viewWillAppear(_ animated: Bool) {
           handleRefresh()
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        handleRefresh()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (organizeServices.handleRefresh), for: UIControlEvents.valueChanged)
        orgnizeServices.delegate = self
        orgnizeServices.dataSource = self
        orgnizeServices.semanticContentAttribute = .forceRightToLeft
        // Do any additional setup after loading the view.
    }
    
    @objc private func handleRefresh() {
        API.getsubServices (ms_id: ms_id) {(error: Error?, location_list:[subServices]?) in
            if let location_list = location_list {
                self.location_list = location_list
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                self.orgnizeServices.reloadData()
            }
        }
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "الخدمات التنظيمية",image: UIImage(named: "tanzeem"))
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let padding: CGFloat =  50
    //        let collectionViewSize = collectionView.frame.size.width - padding
    //
    //        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    //    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Set the number of items in your collection view.
        return location_list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Access
        let cell = orgnizeServices.dequeueReusableCell(withReuseIdentifier: "organizeCell", for: indexPath) as! organizeCell
        // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
        // cell.visualImage.image = images[indexPath.row]
        cell.orgnizeLabel.text = location_list[indexPath.row].s_name
        let strin = self.location_list[indexPath.row].s_image
        
        cell.orgnizeImage.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/pro_images/\(strin)", indicatorColor: .gray, errorImage: UIImage(named: "LOGO")!, imageView: cell.orgnizeImage)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let s_id = location_list[indexPath.row].s_id
        let ms_id = 2
        let def = UserDefaults.standard
        def.setValue(s_id, forKey: "s_id")
        def.setValue(ms_id, forKey: "ms_id")
        def.synchronize()
        
       // self.performSegue(withIdentifier: "ccc", sender: self)
        
    }
    
}
    

