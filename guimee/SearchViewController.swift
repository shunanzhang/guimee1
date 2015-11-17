//
//  SearchViewController.swift
//  guimee
//
//  Created by Shunan Zhang on 11/15/15.
//  Copyright © 2015 Shunan Zhang. All rights reserved.
//

import UIKit
import AFNetworking

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [NSDictionary]!
    
    //var names: [String]!
    
    //let itemNames = ["dress 1", "dress 2", "dress 3", "dress 4", "dress 5", "dress 6"]
    
    //let imageArray = [UIImage(named: "Dress1_"), UIImage(named: "Dress2_"), UIImage(named: "Dress3_"), UIImage(named: "Dress4_"), UIImage(named: "Dress5_"), UIImage(named: "Dress6_")]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        items = []
        
        let url = NSURL(string: "http://api.walmartlabs.com/v1/search?apiKey=ta8supx3ehdmwws2wq94vthd&query=dress")!
        
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            
            self.items = json["items"] as! [NSDictionary]
            
            self.collectionView.reloadData()
            
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        var item = items[indexPath.row]
        
        var title = item["name"] as! String
        
        var itemImageURLString = item.valueForKeyPath("thumbnailImage") as! String
        
        cell.titleLabel.text = title
        
        //cell.imageView.setImageWithURL (NSURL(string: itemImageURLString)!)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetailSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailSegue" {
            
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! ItemDetailViewController
            
            //vc.itemImage = self.imageArray[indexPath.row]!
            //vc.title = self.itemNames[indexPath.row]
            
            
        }
    }
}
