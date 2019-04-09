//
//  CompanyDetails.swift
//  TripleA
//
//  Created by Mohammed Gamal on 2/4/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import KImageView
import ImageSlideshow
import GoogleMaps

class CompanyDetails: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
   
//let localSource = [ImageSource(imageString: "img1")!, ImageSource(imageString: "img2")!, ImageSource(imageString: "img3")!, ImageSource(imageString: "img4")!]
   
    
   var jsonArray: [String] = []
     var refresher : UIRefreshControl!
    var offer_list = [companyOffers]()
    var details_list = [companyDetails]()
    var gallaris_list = [companyWorkgallaries]()
    var service_list = [companyServices]()
    var client_list = [companyClients]()
    @IBOutlet weak var companyPicture: UIImageView!
    @IBOutlet weak var viewMap: GMSMapView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyDescription: UILabel!
    @IBOutlet weak var offerName: UILabel!
    @IBOutlet weak var offerDescription: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var clientsCollectionView: UICollectionView!
    @IBOutlet weak var upView: UIView!
    
    @IBOutlet weak var backBTn: UIBarButtonItem!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var dd: UIBarButtonItem!
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var addressLabel: UILabel!
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if revealViewController() != nil {
            
            dd.target = revealViewController()
            dd.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.revealViewController().panGestureRecognizer()
            self.revealViewController()?.tapGestureRecognizer()
            
        }
       
   
        
        let textAttributes = [NSForegroundColorAttributeName: UIColor.red , NSFontAttributeName: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // change selected bar color
        companyPicture.layer.masksToBounds = true
        companyPicture.layer.borderWidth = 5
      //  let yourColor : UIColor = UIColor (red:0.90, green:0.18, blue:0.18, alpha:1.0)
        
        companyPicture.layer.borderColor =  UIColor.white.cgColor
       
        refresher = UIRefreshControl()
        clientsCollectionView.delegate = self
        clientsCollectionView.dataSource = self
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (CompanyDetails.handleCompanyOffers), for: UIControlEvents.valueChanged)
        refresher.addTarget(self, action: #selector (CompanyDetails.handleCompanyDetails), for: UIControlEvents.valueChanged)
        refresher.addTarget(self, action: #selector (CompanyDetails.getCompanyWorkgallaries), for: UIControlEvents.valueChanged)
        refresher.addTarget(self, action: #selector (CompanyDetails.getCompanyServices), for: UIControlEvents.valueChanged)
        refresher.addTarget(self, action: #selector (CompanyDetails.getCompanyClients), for: UIControlEvents.valueChanged)
      let Latitude = helper.getc_lattitude()
      let  longitude = helper.getc_longitude()
        
        
        
        clientsCollectionView.addSubview(refresher)
        
        serviceCollectionView.addSubview(refresher)
        handleCompanyOffers()
        handleCompanyDetails()
        getCompanyClients()
        getCompanyServices()
        getCompanyWorkgallaries()
        
        slideshow.slideshowInterval = 5.0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
            print("current page:", page)
        }
        
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
      
      //  slideshow.setImageInputs(arr)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(CompanyDetails.didTap))
        slideshow.addGestureRecognizer(recognizer)
        // outletes
     
        // Do any additional setup after loading the view.
        backBTn.setTitleTextAttributes(textAttributes, for: .normal)
    }
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
   
    @IBAction func HomeTapped(_ sender: UIBarButtonItem) {
       self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func handleCompanyOffers() {
        let def = UserDefaults.standard
        let c_id = def.object(forKey: "c_id")
      
        API.getCompanyOffers (c_id: c_id! as! Int) {(error: Error?, offer_list:[companyOffers]?) in
            if let offer_list = offer_list {
                self.offer_list = offer_list
               self.offerName.text = offer_list.first!.o_name
               self.offerPrice.text = offer_list.first!.o_price
               self.offerDescription.text = offer_list.first!.o_description
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
               
            
        }
    }
    }
    @objc private func handleCompanyDetails() {
        let def = UserDefaults.standard
        let c_id = def.object(forKey: "c_id")
        API.getCompanyDetails (c_id: c_id! as! Int) {(error: Error?, details_list:[companyDetails]?) in
            if let details_list = details_list {
                self.details_list = details_list
                self.companyName.text = details_list.first!.c_name
                self.companyDescription.text = details_list.first!.c_description
                self.title = details_list.first!.c_name
                let strin = self.details_list.first!.c_image
                let c_phone = self.details_list.first!.c_phone as String
                let c_mail = self.details_list.first!.c_mail as String
                let c_facebook = self.details_list.first!.c_facebook as String
                let c_instagram = self.details_list.first!.c_instagram as String
                let c_twitter = self.details_list.first!.c_twitter as String
                let c_lattitude = self.details_list.first!.c_lattitude as Double
                 let c_longitude = self.details_list.first!.c_longitude as Double
                
                let def = UserDefaults.standard
                def.setValue(c_phone, forKey: "c_phone")
                 def.setValue(c_mail, forKey: "c_mail")
                def.setValue(c_facebook, forKey: "c_facebook")
                def.setValue(c_instagram, forKey: "c_instagram")
                def.setValue(c_twitter, forKey: "c_twitter")
                def.setValue(c_longitude, forKey: "c_longitude")
                def.setValue(c_lattitude, forKey: "c_lattitude")
               
                def.synchronize()
                
                self.companyPicture.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/company_images/\(strin)", indicatorColor: .gray, errorImage: UIImage(named: "LOGO")!, imageView: self.companyPicture)
                self.addressLabel.text = self.details_list.first!.c_address
                let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: c_longitude, longitude: c_lattitude, zoom: 17.0)
                
                self.viewMap.camera = camera
                let position = CLLocationCoordinate2D(latitude: c_longitude, longitude: c_lattitude)
                let marker = GMSMarker(position: position)
                marker.title = details_list.first!.c_name
                marker.map = self.viewMap
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                
                
            }
        }
    }

    @objc private func getCompanyWorkgallaries() {
        let def = UserDefaults.standard
        let c_id = def.object(forKey: "c_id")
        API.getCompanyWorkgallaries (c_id: c_id! as! Int) {(error: Error?, gallaris_list:[companyWorkgallaries]?) in
            if let gallaris_list = gallaris_list {
                self.gallaris_list = gallaris_list
                
                for item in gallaris_list {
                    let imageUrl = item.wg_image
                    let url = "https://tripleaevent.com/storage/app/public/workgallary_images/\(imageUrl)"
                    self.jsonArray.append(url)
                }
                let arr =  self.jsonArray.map { AFURLSource(urlString: $0 as! String)!}
                self.slideshow.setImageInputs(arr)
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
            }
        }
    }
    @objc private func getCompanyServices() {
        let def = UserDefaults.standard
        let c_id = def.object(forKey: "c_id")
        API.getCompanyServices (c_id: c_id! as! Int) {(error: Error?, service_list:[companyServices]?) in
            if let service_list = service_list {
                self.service_list = service_list
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                
                self.serviceCollectionView.reloadData()
            }
        }
    }
    @objc private func getCompanyClients() {
        let def = UserDefaults.standard
        let c_id = def.object(forKey: "c_id")
        API.getCompanyClients (c_id: c_id! as! Int) {(error: Error?, client_list:[companyClients]?) in
            if let client_list = client_list {
                self.client_list = client_list
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                self.clientsCollectionView.reloadData()
                
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.serviceCollectionView {
        let yourWidth = serviceCollectionView.bounds.width/4
        let yourHeight = yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
        
        
       
    }
        let yourWidth = clientsCollectionView.bounds.width/4
        
        let yourHeight =  yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.clientsCollectionView {
            return client_list.count // Replace with count of your data for collectionViewA
        }
        
        return service_list.count // Replace with count of your data for collectionViewB
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.clientsCollectionView {
            let cellA = clientsCollectionView.dequeueReusableCell(withReuseIdentifier: "ClientsCell", for: indexPath) as! ClientsCell
            let strin = self.client_list[indexPath.row].client_image
            
           cellA.clientImage.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/client_images/\(strin)", indicatorColor: .gray, errorImage: UIImage(named: "LOGO")!, imageView:  cellA.clientImage)
         //  cellA.clientImage.layer.borderWidth = 2
           // cellA.clientImage.layer.borderColor = UIFontWeightBlack as! CGColor
           
            // Set up cell
            return cellA
        }
            
        else {
           let cellB = serviceCollectionView.dequeueReusableCell(withReuseIdentifier: "serviceCell", for: indexPath) as! serviceCell
            // ...Set up cell
            cellB.serviceName.text = service_list[indexPath.row].s_name
            let strin = self.service_list[indexPath.row].s_image
            
            cellB.serviceImage.ImageFromURL(url: "https://tripleaevent.com/storage/app/public/pro_images/\(strin)", indicatorColor: .gray, errorImage: UIImage(named: "LOGO")!, imageView:  cellB.serviceImage)
            cellB.serviceName.text = service_list[indexPath.row].s_name

            return cellB
        }
    }
    @IBAction func phonePressed(_ sender: Any) {
        
        let number = helper.getphoneNumber()
       
        
        guard let url = URL(string: "tel://" + number!) else { return }
        UIApplication.shared.open(url)

    }
    @IBAction func emailPressed(_ sender: UIButton) {
        let email = helper.getcontactEmail()


        guard let url = URL(string: "message://" + email!) else { return }
        UIApplication.shared.open(url)
       
        
    }
    
    @IBAction func faceBookPressed(_ sender: UIButton) {
        let link = helper.getFaceBook()
        
        UIApplication.shared.openURL(NSURL(string: link!)! as URL)
    }
    
    @IBAction func InstagramPressed(_ sender: UIButton) {
        let link = helper.getInstagram()
        
        UIApplication.shared.openURL(NSURL(string: link!)! as URL)
    }
    
    @IBAction func twitterPressed(_ sender: UIButton) {
        let link = helper.getTwitter()
        
        UIApplication.shared.openURL(NSURL(string: link!)! as URL)
    }
    
    @IBAction func navig(_ sender: Any) {
        let long = helper.getc_longitude()
        let lat = helper.getc_lattitude()
        let link = "https://www.google.com/maps/dir//\(long!),\(lat!)/"
        UIApplication.shared.openURL(NSURL(string: link) as! URL)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
