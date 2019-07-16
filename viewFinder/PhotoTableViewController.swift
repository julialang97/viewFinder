//
//  PhotoTableViewController.swift
//  viewFinder
//
//  Created by Apple on 7/15/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController {

    var photos : [Photos] = []
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToDetail", sender: photos[indexPath.row])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToDetail" {
            // need to get access to View Controller we want to move to
            if let photoDetailView = segue.destination as? PhotoDetailViewController {
                // now we need to say, whichever row was tapped, take that photo
                // and send it to the over view
                if let photoToSend = sender as? Photos {
                    photoDetailView.photo = photoToSend
                }
                
        }
        
    }
}
    
    
        func getPhotos() {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                if let coreDataPhotos = try? context.fetch(Photos.fetchRequest()) as? [Photos] {
                    photos = coreDataPhotos
                    tableView.reloadData()
                    
                }
            }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell is each row in the table
        let cell = UITableViewCell()
        
        let cellPhoto = photos[indexPath.row]
        //text next the the pic on the table view
        cell.textLabel?.text = cellPhoto.caption
        //little picture in the table view
        
        if let cellPhotoImageData = cellPhoto.imageData {
            if let cellPhotoImage = UIImage(data: cellPhotoImageData) {
                cell.imageView?.image = cellPhotoImage
            }
        // Configure the cell...
        }
        return cell
}
    
    override func viewWillAppear(_ animated: Bool) {
        getPhotos()
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                // now that we have access to Core Data, we need to select the row, then delete the photo
                let photoToDelete = photos[indexPath.row]
                // we also need to save the context and reload
                context.delete(photoToDelete)
            }
            // Delete the row from the data source
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getPhotos()
        }
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
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
