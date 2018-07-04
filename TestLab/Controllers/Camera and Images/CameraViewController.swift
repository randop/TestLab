//
//  CameraViewController.swift
//  TestLab
//
//  Created by Randolph on 2/5/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var picture: UIImageView!
    
    @IBAction func cameraTap(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction func photoTap(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func uploadTap(_ sender: Any) {
        if let _ = picture.image {
            let alert = UIAlertController(title: "Upload", message: "Select Upload Option", preferredStyle: .actionSheet)
            let uploadAsBytes = UIAlertAction(title: "As Bytes", style: .default, handler: { _ in
                print("Upload as bytes")
            })
            alert.addAction(uploadAsBytes)
            
            let uploadAsMultipart = UIAlertAction(title: "As Multipart", style: .default, handler: { _ in
                self.doUploadAsMultipart()
            })
            alert.addAction(uploadAsMultipart)
            
            let cancelUpload = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelUpload)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: "Please select a picture from Camera or Photo Library", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doUploadAsMultipart() {
        let url = URL(string: "http://192.168.1.101.xip.io:8080/upload_multipart")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let filename = "\(NSUUID().uuidString).jpg"
        let mimetype = "image/jpeg"
        let imageData = UIImageJPEGRepresentation(picture.image!, 0.7)
    
        var body = Data()
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition:form-data; name=\"image\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData!)
        body.append("\r\n--\(boundary)--\r\n")
        request.httpBody = body
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error.debugDescription)
                return
            }
            print(response.debugDescription)
        }
        task.resume()
    }

}

extension CameraViewController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        picture.image = image
        dismiss(animated:true, completion: nil)
    }
    
}
