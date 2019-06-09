//
//  MoreInformationViewController.swift
//  DownloadImages
//
//  Created by Mr.Ocumare on 08/06/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//
import CoreData
import UIKit

class MoreInformationViewController: UIViewController {

    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var DataLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var Image: UIImageView!
    
    var sendImage : Data? = nil
    var sendDate : String = ""
    var sendData : String = ""
    var sendNameImage : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Image.image = UIImage(data: sendImage!)
        DateLabel.text = sendDate
        DataLabel.text = sendData
        NameLabel.text = sendNameImage
        
        navigationController?.navigationBar.barTintColor = DetermImageColor(at: sendImage!)
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSecondToTherd"{
            let dvc = segue.destination as! BigImageViewController
                dvc.sendImage2 = sendImage
        }
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
