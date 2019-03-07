//
//  selectCountry.swift
//  TripleA
//
//  Created by Mohammed Gamal on 2/6/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit


class selectCountry: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate {
    
    
    let datePicker = UIPickerView()
    var pickOption = ["السعودية"]
     var refresher : UIRefreshControl!
    var cities_list = [cities]()
    var city_list : [String] = []
    var cityID_list : [Int] = []
   

    @IBOutlet weak var selectCountryTF: UITextField!
    @IBOutlet weak var logoHome: UIBarButtonItem!
    @IBOutlet weak var pickerTextField: UITextField!
    @IBOutlet weak var dd: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            dd.target = revealViewController()
            dd.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.revealViewController().panGestureRecognizer()
            self.revealViewController()?.tapGestureRecognizer()
            
        }
        getCities()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (selectCountry.getCities), for: UIControlEvents.valueChanged)
       selectCountryTF.isUserInteractionEnabled = false
        self.pickerTextField.text = "جدة"
      
        let textAttributes = [NSForegroundColorAttributeName: UIColor.red , NSFontAttributeName: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // change selected bar color
        datePicker.delegate = self
        pickerTextField.inputView = datePicker
        // toolbar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height:self.view.frame.size.height/10))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-30.0)
        
        toolBar.barStyle = UIBarStyle.blackOpaque
        toolBar.backgroundColor = UIColor(red:0.83, green:0.25, blue:0.22, alpha:1.0)
        
        toolBar.tintColor = UIColor.white
        
        
        
        
        let todayBtn = UIBarButtonItem(title: "تم", style: UIBarButtonItemStyle.plain, target: self, action: #selector(selectCountry.tappedToolBarBtn))
        
     
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "اختار المدينة"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace], animated: true)
        
        pickerTextField.inputAccessoryView = toolBar
        
        
       
        // Do any additional setup after loading the view.
        
    }
   
    @objc private func getCities() {
       
        API.getCities {(error: Error?, cities_list:[cities]?) in
            if let cities_list = cities_list {
                self.cities_list = cities_list
                for item in cities_list {
                    let city = item.city_name
                   
                    self.city_list.append(city)
                }
                for item in cities_list {
                    let cityID = item.city_id
                    
                    self.cityID_list.append(cityID)
                }
                
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                
                self.datePicker.reloadAllComponents()
            }
        }
    }
   
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
       
        
        pickerTextField.resignFirstResponder()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return city_list.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return city_list[row]
    }
    
    func pickerView( pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = city_list[row]
        let cityID = cityID_list[row]
        let def = UserDefaults.standard
        def.setValue(cityID, forKey: "cityID")
        def.synchronize()
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text =  city_list[row]
        let cityID = cityID_list[row]
        let def = UserDefaults.standard
        def.setValue(cityID, forKey: "cityID")
        def.synchronize()
        
    }
    
    @IBAction func HomeTapped(_ sender: UIBarButtonItem) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "mainPage") as! mainPage
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
        revealViewController().pushFrontViewController(newFrontController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
     pickerTextField.text = pickOption[row]
     datePicker.isHidden = true;
        // Pass the selected object to the new view controller.
    }
    */

}
