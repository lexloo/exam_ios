//
//  NotesViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 20/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit

class NotesViewController: BaseUIViewController {
    var questionGuid: String?
    
    @IBOutlet weak var txtNotes: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "笔记"
        
        let saveItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = saveItem
        
        loadPrevNotes()
        txtNotes.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func save(_ sender: UIButton) {
        if txtNotes.text == "" {
            return;
        }
        
        let chapterQuestions = RealmUtil.select(ChapterQuestions.self, forPrimaryKey: questionGuid!)
        
        var notes = chapterQuestions.notes
        if notes == nil {
            notes = Notes()
            notes?.notes = txtNotes.text
            RealmUtil.updateField {
                chapterQuestions.notes = notes;
            }
        } else {
            RealmUtil.updateField {
                chapterQuestions.notes?.notes = txtNotes.text
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func loadPrevNotes() {
        let chapterQuestions = RealmUtil.select(ChapterQuestions.self, forPrimaryKey: questionGuid!)
        
        if let notes = chapterQuestions.notes {
            self.txtNotes.text = notes.notes
        }
    }
}
