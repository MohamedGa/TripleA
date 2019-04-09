//
//  subVisual.swift
//  TripleA
//
//  Created by apple on 1/29/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class subVisual: ButtonBarPagerTabStripViewController {
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)

    @IBOutlet weak var upImage: UIImageView!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var dd: UIBarButtonItem!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    override func viewDidLoad() {
        if revealViewController() != nil {
            dd.target = revealViewController()
            dd.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            self.revealViewController().panGestureRecognizer()
          //  self.revealViewController()?.tapGestureRecognizer()
        }
       
        let textAttributes = [NSForegroundColorAttributeName: UIColor.red , NSFontAttributeName: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        // settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = purpleInspireColor
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
  DispatchQueue.main.async { self.moveToViewController(at: 2, animated: true) }
        guard let ms_id = helper.getMS_ID() else {
                    return
                }
        if ms_id == 1
        {
            var yourImage: UIImage = UIImage(named: "e3lam")!
            upImage.image = yourImage
            self.upLabel.text = "الخدمات الاعلامية"
        }
        if ms_id == 2
        {
            var yourImage: UIImage = UIImage(named: "Path 1458")!
            upImage.image = yourImage
            self.upLabel.text = "الخدمات التنظيمية"
        }
        if ms_id == 3
        {
            var yourImage: UIImage = UIImage(named: "tamween (1)")!
            upImage.image = yourImage
            self.upLabel.text = "التموين والضيافة"
        }
        if ms_id == 4
        {
            var yourImage: UIImage = UIImage(named: "booking")!
            upImage.image = yourImage
            self.upLabel.text = "خدمة الحجوزات"
        }
        backBtn.setTitleTextAttributes(textAttributes, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "companyVisual")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "teamVisual")
        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "personVisual")
        return [ child_3,child_2,child_1]
    }
   
    @IBAction func HomeTapped(_ sender: UIBarButtonItem) {
       self.navigationController?.popViewController(animated: true)
    }
    
}
