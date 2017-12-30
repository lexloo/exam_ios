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
        
        self.loadTabBarChildController();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadTabBarChildController() {
        let questionBankViewController = QuestionBankViewController()
        let questionBankViewItem: UITabBarItem = UITabBarItem(title: "题库", image: UIImage(named: "test"), selectedImage: UIImage(named:"test"))
        questionBankViewController.tabBarItem = questionBankViewItem
        
        let videoViewController = VideoViewController()
        let videoViewItem: UITabBarItem = UITabBarItem(title:"直播", image: UIImage(named: "test"), selectedImage: UIImage(named: "test"))
        videoViewController.tabBarItem = videoViewItem
        
        let myViewController = MyViewController()
        let myViewItem: UITabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "test"), selectedImage: UIImage(named: "test"))
        myViewController.tabBarItem = myViewItem
        
        let tabBarViewControllers = [
            questionBankViewController,
            videoViewController,
            myViewController
        ]
        
        self.setViewControllers(tabBarViewControllers, animated: true)
        self.selectedIndex = 0
    }
}
