//
//  MyViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//

import UIKit

class MyViewController: BaseUITableViewController {
    @IBOutlet weak var vLogo: UIView!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet var tbProp: UITableView!
    
    @IBOutlet weak var lblCategory: UILabel!
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
    
    private func empty() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的"
        
        vLogo.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: 160)
        vLogo.backgroundColor = BaseColor.statusBarColor
        
        tbProp.tableFooterView = UIView();
        
        let avatarClick = UITapGestureRecognizer(target: self, action: #selector(avatarEdit));
        ivAvatar.addGestureRecognizer(avatarClick)
        ivAvatar.isUserInteractionEnabled = true
        
        if let savedImage = UIImage(contentsOfFile: FileUtils.getAvatarFileName("avatar")) {
            ivAvatar.image = savedImage.roundCornersToCircle(withBorder: 40, color: UIColor.orange)
        } else {
            ivAvatar.image = UIImage(color: UIColor.white, size: CGSize(width: 80, height: 80))?.roundCornersToCircle(withBorder: 10, color: UIColor.orange)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.section)-\(indexPath.row)")
        switch indexPath.section {
        case 0:
            let selectKindVC = SelectKindController()
            self.navigationController?.pushViewController(selectKindVC, animated: true)
        default:
            empty()
        }
//        let item = items![indexPath.row]
//
//        if deselectRow {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//
        tableView.deselectRow(at: indexPath, animated: true)
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
            pickVC.allowsEditing = true
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
                        
                        FileUtils.saveAvatar(avatarData!, "avatar")
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
