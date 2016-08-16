//
//  DetailViewController.swift
//  MapKit-Tutorial
//
//  Created by Gelei Chen on 15/8/2016.
//  Copyright © 2016 Gelei Chen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var annotationImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var titleText : String!
    var annotationImage : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = self.titleText
        self.annotationImageView.image = annotationImage
        // Do any additional setup after loading the view.
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

}
