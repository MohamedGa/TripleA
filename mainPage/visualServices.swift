//
//  visualServices.swift
//  TripleA
//
//  Created by apple on 1/26/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class visualServices: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,IndicatorInfoProvider {
    
    @IBOutlet weak var visualCollectionView: UICollectionView!
    var imageFiles = [String]()
    var images = [UIImage]()
    var labelFiles = [String]()
     var refresher : UIRefreshControl!
    var location_list = [subServices]()
    let ms_id = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         handleRefresh()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (visualServices.handleRefresh), for: UIControlEvents.valueChanged)
       visualCollectionView.delegate = self
        visualCollectionView.dataSource = self
        visualCollectionView.addSubview(refresher)
        visualCollectionView.reloadData()
   
        visualCollectionView.semanticContentAttribute = .forceRightToLeft
        // Do any additional setup after loading the view.
    }
    @objc private func handleRefresh() {
        API.getsubServices (ms_id: ms_id) {(error: Error?, location_list:[subServices]?) in
            if let location_list = location_list {
                self.location_list = location_list
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                self.visualCollectionView.reloadData()
            }
        }
    }
   

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "الخدمات الاعلامية",image: UIImage(named: "e3lam3"))
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
        let cell = visualCollectionView.dequeueReusableCell(withReuseIdentifier: "visualCell", for: indexPath) as! visualServicesCell
       
        // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
       // cell.visualImage.image = images[indexPath.row]
        let strin = self.location_list[indexPath.row].s_image
        
        cell.visualImage.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/pro_images/\(strin)", indicatorColor: .gray, errorImage: UIImage(named: "LOGO")!, imageView: cell.visualImage)
        cell.visualName.text = location_list[indexPath.row].s_name
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ms_id = 1
        let s_id = location_list[indexPath.row].s_id
     
        let def = UserDefaults.standard
        def.setValue(s_id, forKey: "s_id")
        def.setValue(ms_id, forKey: "ms_id")
        
        def.synchronize()
        
       // self.performSegue(withIdentifier: "ccc", sender: self)
        
    }
    
}
