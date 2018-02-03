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
        let sbQb = UIStoryboard(name: "QuestionBank", bundle: nil)
        let questionBankViewController = sbQb.instantiateViewController(withIdentifier: "QuestionBankVC") as! QuestionBankViewController
        questionBankViewController.type = "all"
        let naviQuestionBankViewController = UINavigationController(rootViewController: questionBankViewController)
        let questionBankViewItem: UITabBarItem = UITabBarItem(title: "题库", image: UIImage(named: "question_bank"), selectedImage: UIImage(named:"question_bank"))
        naviQuestionBankViewController.tabBarItem = questionBankViewItem
        
        let shareViewController = ShareViewController()
        let shareViewItem: UITabBarItem = UITabBarItem(title:"分享", image: UIImage(named: "share"), selectedImage: UIImage(named: "share"))
        shareViewController.tabBarItem = shareViewItem
        
        let videoViewController = VideoViewController()
        let videoViewItem: UITabBarItem = UITabBarItem(title:"直播", image: UIImage(named: "vedio"), selectedImage: UIImage(named: "vedio"))
        videoViewController.tabBarItem = videoViewItem
        
        let bigVViewController = BigVViewController()
        let bigVViewItem: UITabBarItem = UITabBarItem(title:"大V", image: UIImage(named: "big_v"), selectedImage: UIImage(named: "big_v"))
        bigVViewController.tabBarItem = bigVViewItem
        
        let sbOpts = UIStoryboard(name: "MyOptions", bundle: nil)
        let myViewController = sbOpts.instantiateViewController(withIdentifier: "MyViewVC") as! MyViewController
        let myNaviViewController = UINavigationController(rootViewController: myViewController)
        let myViewItem: UITabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "my_options"), selectedImage: UIImage(named: "my_options"))
        myNaviViewController.tabBarItem = myViewItem
        
        let tabBarViewControllers = [
            naviQuestionBankViewController,
            shareViewController,
            videoViewController,
            bigVViewController,
            myNaviViewController
        ]
        
        self.setViewControllers(tabBarViewControllers, animated: true)
        self.selectedIndex = 0
    }
}
