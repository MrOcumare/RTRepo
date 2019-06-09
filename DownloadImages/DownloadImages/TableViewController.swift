//
//  TableViewController.swift
//  DownloadImages
//
//  Created by Mr.Ocumare on 08/06/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    let inmageURL = URL(string: "https://source.unsplash.com/random")!
    
    var IRFD = true
    
    var ArrayOfImages : [DownloadedImage] = []
    
    @IBAction func AddNewImage(_ sender: Any) {
        if IRFD {
        
            downloadImage(with: inmageURL)
            
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelagate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<DownloadedImage> = DownloadedImage.fetchRequest()
        do{
            ArrayOfImages = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ArrayOfImages.count;
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell
        let NewVall = ArrayOfImages[indexPath.row]
        
        cell.MyImage.image = UIImage(data: NewVall.addImage!)
        cell.MyImage.layer.masksToBounds = true
        cell.MyImage.layer.cornerRadius = cell.MyImage.frame.size.width / 2
        cell.FirstLabel.text = NewVall.nameImage
        cell.SecondLabel.text = NewVall.addDates
        cell.TherdLabel.text = "Size: \(String(Double(NewVall.sizeImage / 1000))) KB"

        return cell
    }
 
    func downloadImage(with url: URL) {
        
        URLSession.shared.dataTask(with: inmageURL) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.saveNewDats(addData: data!)
                self.tableView.reloadData()
            }
            }.resume()
        
        
    }
    func saveNewDats(addData: Data) {
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelagate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DownloadedImage", in: context)
        let myObject = NSManagedObject(entity: entity!, insertInto: context) as! DownloadedImage
        
        myObject.addImage = addData
        myObject.nameImage = "New image"
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        myObject.addDates = formatter.string(from: currentDateTime)
        
        let int = Int64(addData.count)
        myObject.sizeImage = int
        
        do {
            try context.save()
            ArrayOfImages.append(myObject)
            print("Data caved")
        } catch { print(error.localizedDescription) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FromMainTOSecond"{
            
            if let indexPath = tableView.indexPathForSelectedRow{
                
                let dvc = segue.destination as! MoreInformationViewController
                let sendval = self.ArrayOfImages[indexPath.row]
                dvc.sendImage =  sendval.addImage!
                dvc.sendData = "Size: \(String(Double(sendval.sizeImage / 1000))) KB" 
                dvc.sendDate = sendval.addDates!
                dvc.sendNameImage = sendval.nameImage!
                
            }
        }
    }

   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
  
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        let appDelagate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelagate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DownloadedImage")
//        let object = ArrayOfImages[indexPath.row] as! NSManagedObject
//
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//             context.delete(object)
//            ArrayOfImages.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
//        } else if editingStyle == .insert {
//            print("biba")
//        }
//        do {
//            try context.save()
//        } catch { print(error) }
//    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let renameImage = renameImageAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, renameImage])
    }
    
    func renameImageAction(at indexPath: IndexPath) -> UIContextualAction {
        let dataCell = ArrayOfImages[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "RenameImage") { (action, view, complition) in
            
            
            let ac  = UIAlertController(title: "Rename this Image", message:  "Please rename this image or press cencel", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) {  action in
                let textField = ac.textFields?[0]
                var buffer_name = dataCell.nameImage
                dataCell.nameImage = textField?.text
                if (dataCell.nameImage)?.count == 0 {
                    dataCell.nameImage = buffer_name
                } else {
                    self.tableView.reloadData()
                }
                
                
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            ac.addTextField {
                textField in
            }
            ac.addAction(ok)
            ac.addAction(cancel)
            self.present(ac, animated: true, completion: nil)
            
            complition(true)
        }
        
        action.backgroundColor = .green
        
        
        return action
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Delet") { (action, view, complition) in
            let appDelagate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelagate.persistentContainer.viewContext

            let object = self.ArrayOfImages[indexPath.row] as NSManagedObject
            context.delete(object)
            self.ArrayOfImages.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            do {
                try context.save()
                context.delete(object)
            } catch { print(error) }
            
            complition(true)
        }

        action.backgroundColor = .red
        return action
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
