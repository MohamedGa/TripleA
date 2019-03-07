//
//  mainPage.swift
//  TripleA
//
//  Created by apple on 1/26/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class mainPage: ButtonBarPagerTabStripViewController{
    @IBOutlet weak var dd: UIBarButtonItem!
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    override func viewDidLoad() {
        if revealViewController() != nil {
            
            dd.target = revealViewController()
            dd.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
          self.revealViewController().panGestureRecognizer()
         //   self.revealViewController()?.tapGestureRecognizer()
        }
    DispatchQueue.main.async { self.moveToViewController(at: 4, animated: true) }

        let textAttributes = [NSForegroundColorAttributeName: UIColor.red , NSFontAttributeName: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
       // settings.style.buttonBarItemBackgroundColor = .clear
      //  settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
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
         DispatchQueue.main.async { self.moveToViewController(at: 4, animated: true) }
    }

    @IBAction func HomeTapped(_ sender: UIBarButtonItem) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "mainPage") as! mainPage
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
        revealViewController().pushFrontViewController(newFrontController, animated: true)
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "visualServices")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "organizeServices")
        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "support")
        let child_4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "booking")
      return [child_4, child_3,child_2,child_1]
    }
}
 
