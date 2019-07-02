//
//  ViewController.swift
//  deathNote_app
//
//  Created by Daniil KOZYR on 7/1/19.
//  Copyright © 2019 Daniil KOZYR. All rights reserved.
//

import UIKit


private var notes: [DeathNote] = [DeathNote]()

private func createList() {
    notes.append(DeathNote(name: "James Bond", description: "A lot of movies with him, A lot of movies with him, A lot of movies with him", time: "12 Jul 2039 15:53"))
}

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createList()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewNoteSegue" {
            let nextVC = segue.destination as! AddNoteViewController
            nextVC.delegate = self
        }
    }
    
}

extension TableViewController: UITableViewDataSource {
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

}

extension TableViewController: AddNewDeathNoteDelegate {
    func onCreatedNew(note: DeathNote) {
        notes.append(note)
        tableView.reloadData()
    }
}
