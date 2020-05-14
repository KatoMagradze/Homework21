//
//  AddNoteViewController.swift
//  Homework21
//
//  Created by Kato on 5/14/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {
    
    var loggedUser = ""
    var note: UserNote?
    var isEditingNote = false

    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var noteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if isEditingNote {
            noteButton.setTitle("Edit", for: .normal)
            noteTextView.text = note?.content
        }
        else {
            noteButton.setTitle("Add Note", for: .normal)
        }
    }
    
    @IBAction func onAddNoteTapped(_ sender: UIButton) {
        //save()
        
        if isEditingNote {
            updateNote()
        }
        else {
            save()
        }
    }
    
    private func updateNote() {
        let context = AppDelegate.coreDataContainer.viewContext
            
        self.note?.content = noteTextView.text
            
        do {
            try context.save()
            print("Updated")
        } catch {}
        
    }
    
}

extension AddNoteViewController {
    func save() {
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "UserNote", in: context)
        let userNoteObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        userNoteObject.setValue(noteTextView.text!, forKey: "content")
        userNoteObject.setValue(loggedUser, forKey: "username")
        
        
        do {
            try context.save()
            print("success")
        }
        catch {
            print("failed")
        }
    }
}
