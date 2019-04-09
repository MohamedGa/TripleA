//
//  mainPage.swift
//  TripleA
//
//  Created by apple on 1/26/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import ImageSlideshow

class mainPage: ButtonBarPagerTabStripViewController{
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    var jsonArray: [String] = []
     var gallaris_list = [photoGallery]()
    var refresher : UIRefreshControl!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var dd: UIBarButtonItem!
    @IBOutlet weak var slideshow: ImageSlideshow!
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    override func viewDidLoad() {
        if revealViewController() != nil {
            
            dd.target = revealViewController()
            dd.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
          self.revealViewController().panGestureRecognizer()
         //   self.revealViewController()?.tapGestureRecognizer()
        }
    

        let textAttributes = [NSForegroundColorAttributeName: UIColor.red , NSFontAttributeName: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
       // settings.style.buttonBarItemBackgroundColor = .clear
      //  settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        settings.style.selectedBarHeight = 0.1
        settings.style.buttonBarMinimumLineSpacing = 2
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        settings.style.selectedBarBackgroundColor = UIColor.white
        settings.style.selectedBarVerticalAlignment = .top
       
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
           
            oldCell?.label.textColor = .white
            oldCell?.backgroundColor = UIColor.gray
            
          
            newCell?.label.textColor = UIColor.white
           newCell?.backgroundColor = UIColor(red:0.90, green:0.18, blue:0.18, alpha:1.0)
            
            
        }
        super.viewDidLoad()
         DispatchQueue.main.async { self.moveToViewController(at: 3, animated: false) }
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (mainPage.getCompanyWorkgallaries), for: UIControlEvents.valueChanged)
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
        
        
        backBtn.setTitleTextAttributes(textAttributes, for: .normal)
    }
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    @IBAction func HomeTapped(_ sender: UIBarButtonItem) {
       self.navigationController?.popViewController(animated: true)
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "visualServices")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "organizeServices")
        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "support")
        let child_4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "booking")
      return [child_4, child_3,child_2,child_1]
    }
     func getCompanyWorkgallaries() {
        
        API.getAllPhotoGallaries  {(error: Error?, gallaris_list:[photoGallery]?) in
            if let gallaris_list = gallaris_list {
                self.gallaris_list = gallaris_list
                
                for item in gallaris_list {
                    let imageUrl = item.g_image
                    let url = "https://tripleaevent.com/storage/app/public/gallary_images/\(imageUrl)"
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
}
 
