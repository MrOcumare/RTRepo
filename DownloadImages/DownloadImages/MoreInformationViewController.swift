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
        
        var averageColor: UIColor? {
            guard let inputImage = CIImage(image: UIImage(data: sendImage!)!) else { return nil }
            let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
            
            guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
            guard let outputImage = filter.outputImage else { return nil }
            
            var bitmap = [UInt8](repeating: 0, count: 4)
            let context = CIContext(options: [.workingColorSpace: kCFNull])
            context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
            
            return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
        }
        navigationController?.navigationBar.barTintColor = averageColor
        
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
