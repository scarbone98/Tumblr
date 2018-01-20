//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by Samuel Carbone on 1/16/18.
//  Copyright © 2018 Samuel Carbone. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var imageData: UIImage!
    var data: String = ""
    @IBOutlet weak var postData: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = imageData
        postData.text = data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
