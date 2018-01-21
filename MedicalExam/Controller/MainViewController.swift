//
//  MainController.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
       
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.loadTabBarChildController();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadTabBarChildController() {
        let sb = UIStoryboard(name: "QuestionBank", bundle: nil)
        let questionBankViewController = sb.instantiateViewController(withIdentifier: "QuestionBankVC") as! QuestionBankViewController
        questionBankViewController.type = "all"
        let questionBankViewItem: UITabBarItem = UITabBarItem(title: "题库", image: UIImage(named: "question_bank"), selectedImage: UIImage(named:"question_bank"))
        questionBankViewController.tabBarItem = questionBankViewItem
        
        let shareViewController = VideoViewController()
        let shareViewItem: UITabBarItem = UITabBarItem(title:"分享", image: UIImage(named: "share"), selectedImage: UIImage(named: "share"))
        shareViewController.tabBarItem = shareViewItem
        
        let videoViewController = VideoViewController()
        let videoViewItem: UITabBarItem = UITabBarItem(title:"直播", image: UIImage(named: "vedio"), selectedImage: UIImage(named: "vedio"))
        videoViewController.tabBarItem = videoViewItem
        
        let bigVViewController = VideoViewController()
        let bigVViewItem: UITabBarItem = UITabBarItem(title:"大V", image: UIImage(named: "big_v"), selectedImage: UIImage(named: "big_v"))
        bigVViewController.tabBarItem = bigVViewItem
        
        let myViewController = MyViewController()
        let myViewItem: UITabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "my_options"), selectedImage: UIImage(named: "my_options"))
        myViewController.tabBarItem = myViewItem
        
        let tabBarViewControllers = [
            questionBankViewController,
            shareViewController,
            videoViewController,
            bigVViewController,
            myViewController
        ]
        
        self.setViewControllers(tabBarViewControllers, animated: true)
        self.selectedIndex = 0
    }
}
