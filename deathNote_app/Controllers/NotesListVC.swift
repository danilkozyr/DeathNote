//
//  ViewController.swift
//  deathNote_app
//
//  Created by Daniil KOZYR on 7/1/19.
//  Copyright © 2019 Daniil KOZYR. All rights reserved.
//

import UIKit

class NotesListVC: UIViewController {

    private var notes: [DeathNote] = [DeathNote]()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        initializeNote()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewNoteSegue" {
            let nextVC = segue.destination as! AddNoteVC
            nextVC.delegate = self
        }
    }
    
    private func initializeNote() {
        notes.append(DeathNote(name: "Kurt Cobain",
                               description: "I don’t have the passion anymore, and so remember, it’s better to burn out than to fade away.",
                               time: "12 Jul 2039 15:53"))
        notes.append(DeathNote(name: "Jiah Khan",
                               description: "I don’t know why destiny brought us together. After all the pain, the rape, the abuse, the torture I have seen previously I didn’t deserve this.",
                               time: "23 Jun 2049 12:13"))
        notes.append(DeathNote(name: "Vincent Van Gogh",
                               description: "The sadness will last forever.",
                               time: "28 Feb 2033 02:23"))
        notes.append(DeathNote(name: "Marilyn Monroe",
                               description: "I sound crazy, but I think I’m going crazy. I get before a camera and my concentration and everything I’m trying to learn leaves me. Then I feel like I’m not existing in the human race at all.",
                               time: "01 Jun 2020 22:00"))
        notes.append(DeathNote(name: "Robin Williams",
                               description: "I’m done with that. Time to go. No more to come.”",
                               time: "01 Jun 2020 22:00"))
        
        
    }

}

extension NotesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deathNoteCellIdentifier") as! DeathNoteCell
        let note = notes[indexPath.row]
        
        cell.nameLabel.text = note.name
        cell.descriptionTextView.text = note.description
        cell.dateLabel.text = note.time
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

}

extension NotesListVC: AddNewDeathNoteDelegate {
    func onCreatedNew(note: DeathNote) {
        notes.append(note)
        tableView.reloadData()
    }
}
