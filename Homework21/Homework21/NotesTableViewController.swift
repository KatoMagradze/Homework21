//
//  NotesTableViewController.swift
//  Homework21
//
//  Created by Kato on 5/14/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UIViewController {
    
    var loggedUsername = ""
    var notesArr = [UserNote]()
    var note: UserNote?
    
    var isEditingNote = false

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetch()
    }
    
    func deletePost(note: UserNote) {
        let context = AppDelegate.coreDataContainer.viewContext
        
        context.delete(note)
        
        do {
            try context.save()
        } catch {}
    }
    
    @IBAction func onAddTapped(_ sender: UIBarButtonItem) {
        isEditingNote = false
        performSegue(withIdentifier: "add_note_segue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "add_note_segue" {
            if let destinationVC = segue.destination as? AddNoteViewController {
                destinationVC.loggedUser = self.loggedUsername
                destinationVC.note = self.note
                destinationVC.isEditingNote = self.isEditingNote
            }
        }
    }
    


}
extension NotesTableViewController {
    func fetch() {
        let container = AppDelegate.coreDataContainer
        
        let context = container.viewContext
        let request: NSFetchRequest<UserNote> = UserNote.fetchRequest()
        
        self.notesArr.removeAll()
        
        do {
            let result = try context.fetch(request)
            guard let data = result as? [NSManagedObject] else {return}
            
            
            for item in data {
                if let p = item as? UserNote {
                    if p.username == self.loggedUsername {
                        
                        /*let myNote = Note(content: p.content!, username: p.username!)*/
                        self.notesArr.append(p)
                    }
                }
            }
        }
        catch {}
        tableView.reloadData()
    }
}

extension NotesTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes_cell", for: indexPath) as! NotesCell
        
        cell.noteLabel.text = notesArr[indexPath.row].content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            
            self.deletePost(note: self.notesArr[indexPath.row])
            
            self.notesArr.remove(at: indexPath.row)
            //tableView.reloadData()
            
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            
            self.note = self.notesArr[indexPath.row]
            self.isEditingNote = true
            self.performSegue(withIdentifier: "add_note_segue", sender: nil)
        }
        
        let config = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return config
    }
    
    
}

/*
struct Note {
    var content: String
    var username: String
}
 */
