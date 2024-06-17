//
//  PendingViewController.swift
//  TaskManagementApp
//
//  Created by Sajani Jayasinghe on 2023-04-21.
//

import UIKit

class PendingViewController: UIViewController {

    var pending = [TaskManageEntity]()
    @IBOutlet var pendingList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    override func viewWillAppear(_ animated: Bool) {
        pending = DBManager.share.fetchAllPendingTasks()
        pendingList.reloadData()
    }
    

}

extension PendingViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pending.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PendingTableViewCell
        
        let onePending = pending[indexPath.row]
        cell.pendingName.text = onePending.name
        cell.pendingDuration.text = "\(onePending.taskduration)"
        cell.pendingType.text = onePending.type
       
        if let imageData = onePending.image {
            cell.pendingImage.image = UIImage(data: imageData)
        }else {
            cell.pendingImage.image = nil
        }
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor(red: CGFloat(235/255.0), green: CGFloat(236/255.0), blue: CGFloat(239/255.0), alpha: CGFloat(1.0)).cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = storyboard?.instantiateViewController(withIdentifier: "SpecificTaskViewController") as? SpecificTaskViewController {
            task.currentTask = pending[indexPath.row]
            self.navigationController?.pushViewController(task, animated: true)
        }
    }

     //delete
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
         if editingStyle == UITableViewCell.EditingStyle.delete{

         let dialogMessage = UIAlertController(title: "Delete Confirmation", message: "Are you sure, you want to delete this Task?", preferredStyle: .alert)

         let OK = UIAlertAction(title: "OK", style: .default) { [self] (action) -> Void in
          do{
             try DBManager.share.context.delete(self.pending[indexPath.row])
          } catch {
             print("Error in delete")
          }

              DBManager.share.saveContext()
              pending.remove(at: indexPath.row)

              tableView.deleteRows(at: [indexPath], with: .automatic)
             }
                 let Cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                 print("Cancel")

              }
                   dialogMessage.addAction(OK)
                   dialogMessage.addAction(Cancel)
                   self.present(dialogMessage, animated: true, completion: nil)
            }
         }
}
