//
//  EditTaskViewController.swift
//  TaskManagementApp
//
//  Created by Thusith Hettiarachchi on 2024-04-22.
//
import UIKit

class EditTaskViewController: UIViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet var editname: UITextField!
    @IBOutlet var edittype: UITextField!
    @IBOutlet var editDate: UIDatePicker!
    @IBOutlet var editNoOfItems: UISlider!
    @IBOutlet var editDesc: UITextView!
    @IBOutlet var sliderCount: UITextField!
    @IBOutlet var editImage: UIImageView!
    @IBOutlet var uploadImageStatus: UITextField!
    
    
    var uTask : TaskManageEntity? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editDesc.text = uTask?.shortdescription
        editname.text = uTask?.name
        edittype.text = uTask?.type
        
        if let dateData = uTask?.taskdate {
            editDate.date = dateData
        }
        
        if let sliderData = uTask?.taskduration {
            editNoOfItems.value = Float(sliderData)
        }
        
        sliderCount.text =  "\(Int(editNoOfItems.value)) Days"
        
        if let data = uTask?.image {
            editImage.image = UIImage(data: data)
        }else {
            editImage.image = nil
        }

        uploadImageStatus.text = "Click to Upload Image"
    }
    
    
    @IBAction func onChangeSlider(_ sender: Any) {
        sliderCount.text =  "\(Int(editNoOfItems.value)) Days"
    }
    
    @IBAction func btnSelect(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        uTask?.name = editname.text
        uTask?.type = edittype.text
        uTask?.shortdescription = editDesc.text
        uTask?.taskduration = Int16(editNoOfItems.value)
        uTask?.taskdate = editDate.date
        uTask?.image = editImage.image?.jpegData(compressionQuality: 1)
        
        DBManager.share.saveContext()
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SpecificTaskViewController") as? SpecificTaskViewController{
            vc.currentTask = uTask
            self.navigationController?.pushViewController(vc, animated: true)
      }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return}
        editImage.image = userPickedImage
        if (editImage != nil) {
            uploadImageStatus.text = "Image Uploaded"
        }else{
            uploadImageStatus.text = "Click to Update Image"
        }

        picker.dismiss(animated: true)
    }
    
}
