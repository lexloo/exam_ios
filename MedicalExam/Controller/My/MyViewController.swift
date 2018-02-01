//
//  MyViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//

import UIKit

class MyViewController: UITableViewController {
    @IBOutlet weak var vLogo: UIView!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet var tbProp: UITableView!
    
    @IBAction func exitClick(_ sender: UIButton) {
        exit(0)
    }

    private lazy var pickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = true
        
        return pickVC
    }()
    private var avatarData: Data?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的"
        
        vLogo.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: 160)
        vLogo.backgroundColor = BaseColor.statusBarColor
        
        ivAvatar.layer.cornerRadius = ivAvatar.frame.size.width / 2
        ivAvatar.clipsToBounds = true
        
        tbProp.tableFooterView = UIView();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickVC.sourceType = .camera
            self.present(pickVC, animated: true, completion: nil)
        } else {
            MessageUtils.alert(viewController: self, message: "camera")
        }
    }
    
    private func openLibrary() {
        pickVC.sourceType = .photoLibrary
        pickVC.allowsEditing = true
        present(pickVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let typeStr = info[UIImagePickerControllerMediaType] as? String {
            if typeStr == "public.image" {
                if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                    if UIImagePNGRepresentation(image) == nil {
                        avatarData = UIImageJPEGRepresentation(image, 0.8)
                    } else {
                        avatarData = UIImagePNGRepresentation(image)
                    }
                    
                    if avatarData != nil {
                        
                    }
                }
            }
        }
    }
}
