//
//  QuestionBankController.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//

import UIKit

class QuestionBankViewController: UIQuestionBankBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var vTools: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "题库"
        self.view.backgroundColor = UIColor.brown
        
        initViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func errorQuestionClick(_ sender: UIButton) {
        let sb = UIStoryboard(name: "QuestionBank", bundle: nil)
        let next = sb.instantiateViewController(withIdentifier: "TypeQuestionListVC") as! TypeQuestionViewController
        next.type = "error"
        self.present(next, animated: true, completion: nil)
    }
    
    @IBAction func likesClick(_ sender: UIButton) {
        let sb = UIStoryboard(name: "QuestionBank", bundle: nil)
        let next = sb.instantiateViewController(withIdentifier: "TypeQuestionListVC") as! TypeQuestionViewController
        next.type = "liked"
        self.present(next, animated: true, completion: nil)
    }
    
    @IBAction func notesClick(_ sender: UIButton) {
        let sb = UIStoryboard(name: "QuestionBank", bundle: nil)
        let next = sb.instantiateViewController(withIdentifier: "TypeQuestionListVC") as! TypeQuestionViewController
        next.type = "notes"
        self.present(next, animated: true, completion: nil)
    }
    func initViews() {
        initTableView()
    }
    
    func initTableView() {
        SectionModel.loadSections {
            (models) in self.dataSource = models
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(tableView)
    }
}
