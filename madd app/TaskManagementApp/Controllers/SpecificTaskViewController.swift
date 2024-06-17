//
//  SpecificTaskViewController.swift
//  TaskManagementApp
//
//  Created by Thusith Hettiarachchi on 2024-04-22.
//

import UIKit

class SpecificTaskViewController: UIViewController , UINavigationControllerDelegate{

    var currentTask: (TaskManageEntity)? = nil

    
    @IBOutlet var taskImage: UIImageView!
    @IBOutlet var taskName: UILabel!
    @IBOutlet var taskType: UILabel!
    @IBOutlet var taskDate: UILabel!
    @IBOutlet var taskDuration: UILabel!
    @IBOutlet var taskDesc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskDesc.text = currentTask?.shortdescription
        taskName.text = currentTask?.name
        taskType.text = currentTask?.type
        taskImage.layer.cornerRadius = 10
        if let data = currentTask?.image{
            taskImage.image = UIImage(data: data)
        }else {
            taskImage.image = nil
        }
        
        if let date = currentTask?.taskdate , let taskduration = currentTask?.taskduration{
                  let dateFormatter = DateFormatter()
                  dateFormatter.dateStyle = .medium
                  dateFormatter.timeStyle = .none

                  dateFormatter.locale = Locale(identifier: "ja_JP")

            taskDate.text = "\(dateFormatter.string(from: date))"
            taskDuration.text = "\(taskduration) days"
              }

    }
    
    @IBAction func closeTask(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Confirm Task", message: "Are you sure, Did you Closed your Task?", preferredStyle: .alert)
        
        let OK = UIAlertAction(title: "OK", style: .default) { [self] (action) -> Void in
            if let vc = storyboard?.instantiateViewController(withIdentifier: "TaskManageViewController") as? TaskManageViewController{
                    self.navigationController?.pushViewController(vc, animated: true)
            }
            
            self.currentTask?.taskstatus = true
            
            DBManager.share.saveContext()
            
        

        }
       
        let Cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel")
        }
        dialogMessage.addAction(OK)
                    dialogMessage.addAction(Cancel)
                    self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        if let specific = storyboard?.instantiateViewController(withIdentifier: "EditTaskViewController") as? EditTaskViewController {
            specific.uTask = currentTask
            self.navigationController?.pushViewController(specific, animated: true)
        }
      
    }
}
