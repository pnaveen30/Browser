
//
//  ViewController.swift
//  Browser
//
//  Created by RAVI on 03/08/18.
//  Copyright © 2018 RAVI. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIWebViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var tabCount:Int = 1
    var webStr = NSString()
    
    var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height-50)
        //flowLayout. = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        self.loader.isHidden = true
        
        self.createGradientLayer()
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.opacity = 0.5
        
        self.view.layer.addSublayer(gradientLayer)
    }
    
    @IBAction func addNewTabBtn(_ sender: Any) {
        
        tabCount = tabCount+1
        webStr = ""
        collectionView.reloadData()
        
    }
   
    
    @IBAction func closeTabBtn_tap(_ sender: UIButton) {
        
        tabCount = tabCount-1
        webStr = ""
        collectionView.reloadData()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.loader.isHidden = false
        self.loader.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.loader.isHidden = true
        self.loader.stopAnimating()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CVCell
        cell.goBtn.tag = indexPath.row
        cell.webView.tag = indexPath.row
        cell.progressBar.tag = indexPath.row
        cell.textField.tag = indexPath.row
        cell.textField.delegate = self
        cell.goBtn.addTarget(self, action: #selector(goBtnTap), for: .touchUpInside)
        
        if(webStr != ""){
            let str:NSString = webStr.replacingOccurrences(of: "", with: "+") as NSString
            //let url = URL(string: "https://www.google.co.in/search?q=\(str)")
            let url = URL(string: "https://duckduckgo.com/?q=\(str)&kp=-1&kl=us-en")
            cell.webView.loadRequest(URLRequest(url: url!))
        }
        cell.webView.delegate = self;
        return cell
    }
    
    @IBAction func goBtnTap(_ sender: UIButton){
        
        let textField = UITextField()
        textField.tag = sender.tag
        self.view.endEditing(true)
        print(textField.text!)
        self.collectionView.reloadData()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         print(textField.text!)
        webStr = textField.text! as NSString
        
    }
    
    
}

