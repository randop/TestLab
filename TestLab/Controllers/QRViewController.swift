//
//  QRViewController.swift
//  TestLab
//
//  Created by Randolph on 7/28/19.
//  Copyright © 2019 Randolph. All rights reserved.
//

import UIKit
import AVFoundation

class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var cameraView: UIView!
    
    @IBAction func buttonTap(_ sender: Any) {
        startCapture()
    }
    
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    let DB = DAO.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = AVCaptureSession()
        output = AVCaptureStillImageOutput()
        requestAuthorization()
        // Do any additional setup after loading the view.
    }
    
    func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices: NSArray = AVCaptureDevice.devices() as NSArray;
        for de in devices {
            let deviceConverted = de as! AVCaptureDevice
            if(deviceConverted.position == position){
                return deviceConverted
            }
        }
        return nil
    }
    
    func requestAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            // The user has previously granted permission to access the camera.
            print("permission granted")
            startCapture()
        case .notDetermined:
            // We have never requested access to the camera before.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    guard granted else {
                        // The user denied the camera access request.
                        print("permission denied")
                        return
                    }
                    
                    // The user has granted permission to access the camera.
                    print("permission granted")
                    self.startCapture()
                }
            }
        case .denied, .restricted:
            print("permission denied")
            // The user either previously denied the access request or the
            // camera is not available due to restrictions.
            return
        }
    }
    
    func startCapture() {
        let camera = getDevice(position: .back)
        do {
            input = try AVCaptureDeviceInput(device: camera!)
        } catch let error as NSError {
            print(error)
            input = nil
        }
        if(session?.canAddInput(input!) == true){
            session?.addInput(input!)
            if(session?.canAddOutput(output!) == true){
                session?.addOutput(output!)
            }
            let captureMetadataOutput = AVCaptureMetadataOutput()
            session?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            previewLayer = AVCaptureVideoPreviewLayer(session: session!)
            previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            previewLayer?.frame = cameraView.bounds
            cameraView.layer.addSublayer(previewLayer!)
            session?.startRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //print("metadataOutput \(metadataObjects.count)")
        if metadataObjects.count == 0 {
            return
        }
        for metadataObject in metadataObjects {
            let qrObject = metadataObject as! AVMetadataMachineReadableCodeObject
            if qrObject.type == AVMetadataObject.ObjectType.qr {
                if let qrValue = qrObject.stringValue {
                    let qrID = String(DB.addQr(value: qrValue)!)
                    print(qrID)
                }
            }
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
