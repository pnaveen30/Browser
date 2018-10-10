//
//  CVCell.swift
//  Browser
//
//  Created by RAVI on 03/08/18.
//  Copyright © 2018 RAVI. All rights reserved.
//

import UIKit

class CVCell: UICollectionViewCell {
    @IBOutlet weak var textField: UITextField!
    
    var webStr =  String()
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var goBtn: UIButton!
    
}
