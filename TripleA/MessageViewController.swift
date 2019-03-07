//
//  MessageViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController,UINavigationBarDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var menu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if Language.currentLanguage() == "ar"{
           // revealViewController().rearViewRevealWidth = 200
            menu.target = revealViewController()
            menu.action = #selector(SWRevealViewController.revealToggle(_:))
        }else
        {
         //   revealViewController().rearViewRevealWidth = 200
            menu.target = revealViewController()
            menu.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func changeLang(_ sender: Any) {
        if Language.currentLanguage() == "ar"{
            Language.setAppLanguage(lang: "en-US")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }else
        {
            Language.setAppLanguage(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
        let sb = UIStoryboard(name: "Main", bundle: nil)
        window?.rootViewController = sb.instantiateViewController(withIdentifier: "SWRevealViewController")
        UIView.transition(with: window!, duration: 0.5, options:.transitionCurlUp , animations: nil, completion: nil)
        
}
}

