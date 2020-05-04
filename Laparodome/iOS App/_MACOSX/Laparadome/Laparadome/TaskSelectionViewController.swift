//
//  TaskSelectionViewController.swift
//  Laparadome
//
//  Created by Sam Wu on 4/11/20.
//  Copyright © 2020 Sam Wu. All rights reserved.
//

import UIKit

class TaskSelectionViewController: UIViewController {
    
    let tableView = UITableView()
    
    static let taskCellIdentifier = "taskCell"
    
    private var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        tasks = DecodingHelper.load("tasks_en.json")
        tableView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Task Selection"
    }
    
    private func setUpView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskSelectionViewController.taskCellIdentifier)
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
}

extension TaskSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskSelectionViewController.taskCellIdentifier) as? TaskCell else {
            fatalError()
        }
        
        let task = tasks[indexPath.item]
        
        cell.taskNumberLabel.text = "Task \(task.id)"
        cell.taskNameLabel.text = task.name
        
        return cell
    }
    
    
}

extension TaskSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.item]

        let taskDetailView = TaskDetailViewController(with: task)
        
        navigationController?.pushViewController(taskDetailView, animated: true)
    }
}
