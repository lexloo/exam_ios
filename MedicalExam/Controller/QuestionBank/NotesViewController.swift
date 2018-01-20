//
//  NotesViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 20/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    var questionGuid: String?
    
    @IBOutlet weak var txtNotes: UITextView!
    @IBAction func returnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveClick(_ sender: UIButton) {
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
        
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPrevNotes()
        txtNotes.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadPrevNotes() {
        let chapterQuestions = RealmUtil.select(ChapterQuestions.self, forPrimaryKey: questionGuid!)
        
        if let notes = chapterQuestions.notes {
            self.txtNotes.text = notes.notes
        }
    }
}
