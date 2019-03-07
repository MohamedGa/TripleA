//
//  ClientsCell.swift
//  TripleA
//
//  Created by Mohammed Gamal on 2/5/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit

class ClientsCell: UICollectionViewCell {
    
    @IBOutlet weak var clientImage: UIImageView!
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.red.cgColor
        
    }
}
