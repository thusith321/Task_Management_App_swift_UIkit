//
//  AddTaskViewController.swift
//  TaskManagementApp
//
//  Created by Thusith Hettiarachchi on 2024-04-22.
//

import UIKit

class AddTaskViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var taskName: UITextField!
    @IBOutlet var taskType: UITextField!
    @IBOutlet var taskDate: UIDatePicker!
    @IBOutlet var taskDuration: UISlider!
    @IBOutlet var taskDesc: UITextView!
    @IBOutlet var durationLabel: UITextField!
    @IBOutlet var imageStatus: UITextField!
    
    
    var image : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        durationLabel.text = "\(Int(taskDuration.value)) days"
        imageStatus.text = "Click to Upload Image"
    }
    
    @IBAction func onChageDuration(_ sender: Any) {
        durationLabel.text = "\(Int(taskDuration.value)) days"
    }
    
    
    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)

    }
    
    @IBAction func btnSave(_ sender: Any) {
        
        if let name = taskName.text,
           let shortdescription = taskDesc.text,
           let type = taskType.text{
            if name != "" || type != "" {
            let newTask = TaskManageEntity(context: DBManager.share.context)
            newTask.name = name
            newTask.shortdescription = shortdescription
            newTask.type = type
            newTask.taskdate = taskDate.date
            newTask.taskduration = Int16(taskDuration.value)
            newTask.image = image?.jpegData(compressionQuality: 1)
            newTask.taskstatus = false

            DBManager.share.saveContext()
      
            print (newTask)
                
            let alertController = UIAlertController(title: "Success", message: "Task Added Successfully!!!!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default){ [self] (action) -> Void in
                    if let vc = storyboard?.instantiateViewController(withIdentifier: "TaskManageViewController") as? TaskManageViewController{
                            self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
            }
            else{
                let alertController = UIAlertController(title: "Validation Error", message: "Please fill all the fileds", preferredStyle: .alert)

                let action = UIAlertAction(title: "OK", style: .default){ [
                    self] (action) -> Void in
                }

                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
            }
        }
        else{
            print("Please fill all the field")
        }
    }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let userPickedImage = info[.editedImage] as? UIImage else { return
            }
            image = userPickedImage
            if (image != nil) {
                imageStatus.text = "Image Uploaded"
            }else{
                imageStatus.text = "Click to Update Image"
            }
            picker.dismiss(animated: true)
        }
}
