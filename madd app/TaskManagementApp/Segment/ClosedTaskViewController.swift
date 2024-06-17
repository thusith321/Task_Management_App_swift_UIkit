//
//  ClosedTaskViewController.swift
//  TaskManagementApp
//
//  Created by Sajani Jayasinghe on 2023-04-22.
//

import UIKit

class ClosedTaskViewController: UIViewController {

    @IBOutlet var closedTableView: UITableView!
    
    var closedTask = [TaskManageEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        closedTask = DBManager.share.fetchAllCompeleteTask()
        closedTableView.reloadData()
    }
}

extension ClosedTaskViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        closedTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClosedTableViewCell
        let closed = closedTask[indexPath.row]
        cell.closedName.text = closed.name
        cell.closedType.text = closed.type
        cell.closedDays.text = "\(closed.taskduration)"
        
        if let imageData = closed.image {
            cell.closedImage.image = UIImage(data: imageData)
        }else {
            cell.closedImage.image = nil
            
        }
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor(red: CGFloat(235/255.0), green: CGFloat(236/255.0), blue: CGFloat(239/255.0), alpha: CGFloat(1.0)).cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            let dialogMessage = UIAlertController(title: "Delete Confirmation", message: "Are you sure, you want to delete this Task?", preferredStyle: .alert)
            
            let OK = UIAlertAction(title: "OK", style: .default) { [self] (action) -> Void in

                do{
                    try DBManager.share.context.delete(self.closedTask[indexPath.row])
                }
                catch {
                    print("Error in delete")
                }
                DBManager.share.saveContext()
                closedTask.remove(at: indexPath.row)
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

