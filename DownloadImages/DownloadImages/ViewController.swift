//
//  ViewController.swift
//  DownloadImages
//
//  Created by Mr.Ocumare on 06/06/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    @IBOutlet weak var Image: UIImageView!
    
    let inmageURL = URL(string: "https://source.unsplash.com/random")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage(with: inmageURL)
        
    }

    func downloadImage(with url: URL) {
        URLSession.shared.dataTask(with: inmageURL) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.Image.image = UIImage(data: data!)
                print("MyDATA------------>\(data!)")
                print("MyDATA------------>\(response!)")
                
               ////-------------
                let currentDateTime = Date()
                
                // initialize the date formatter and set the style
                let formatter = DateFormatter()
                formatter.timeStyle = .medium
                formatter.dateStyle = .long
                
                print("MyDATA------------>\(formatter.string(from: currentDateTime))")
                ////-------------------
            
            }
        }.resume()
    }
    


}


