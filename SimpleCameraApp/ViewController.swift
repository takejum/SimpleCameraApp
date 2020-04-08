//
//  ViewController.swift
//  SimpleCameraApp
//
//  Created by Jumpei Takeshita on 2020/04/06.
//  Copyright © 2020 Jumpei Takeshita. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var backImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status){

            case .authorized:
                print("It is authorized")
            
            case .denied:
                print("It is denied")
                
            case .notDetermined:
                print("It was not determined")
                
            case .restricted:
                print("It is restricted")
            }
        }
    }
    
    @IBAction func openCamera(_ sender: Any) {
        let sourceType = UIImagePickerController.SourceType.camera
        
        //check if camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.allowsEditing = true
            cameraPicker.delegate = self
            present(cameraPicker, animated: true, completion: nil)
        }else{
            print("Error!")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func openAlbun(_ sender: Any) {
        let sourceType = UIImagePickerController.SourceType.photoLibrary
        
        //check if camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.allowsEditing = true
            cameraPicker.delegate = self
            present(cameraPicker, animated: true, completion: nil)
        }else{
            print("Error!")
        }
    }
    
    //fuction will be called when photo is taken or photo is selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.editedImage] as? UIImage {
            backImageView.image = pickedImage
            
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    
    //function to share photos
    @IBAction func shareButton(_ sender: Any) {
        let text = ""
        let image = backImageView.image?.jpegData(compressionQuality: 0.2)
        let items = [text, image] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    
    
    
    
    
}

