//
//  BigImageViewController.swift
//  DownloadImages
//
//  Created by Mr.Ocumare on 08/06/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class BigImageViewController: UIViewController {
    @IBOutlet weak var ImageBig: UIImageView!
    
    var sendImage2 : Data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageBig.image = UIImage(data: sendImage2!)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
