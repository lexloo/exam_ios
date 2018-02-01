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
        
        //ivAvatar.layer.cornerRadius = ivAvatar.frame.size.width / 2
        //ivAvatar.clipsToBounds = true
        ivAvatar.image = UIImage(color: UIColor.white, size: CGSize(width: 80, height: 80))?.roundCornersToCircle(withBorder: 10, color: UIColor.orange)
        
        tbProp.tableFooterView = UIView();
        
        let avatarClick = UITapGestureRecognizer(target: self, action: #selector(avatarEdit));
        ivAvatar.addGestureRecognizer(avatarClick)
        ivAvatar.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func avatarEdit() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            (UIAlertAction) in
            self.openCamera()
        }))
        
        sheet.addAction(UIAlertAction(title: "Photo", style: .default, handler: {
            (UIAlertAction) in
            self.openLibrary()
        }))
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(sheet, animated: true, completion: nil)
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
                        ivAvatar.image = UIImage(data: avatarData!)?.resize(toSize: CGSize(width: 80, height: 80))?.roundCornersToCircle(withBorder: 40, color: UIColor.orange)
                    }
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
