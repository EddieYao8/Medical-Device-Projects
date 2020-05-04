//
//  TaskDetailViewController.swift
//  Laparadome
//
//  Created by Sam Wu on 4/11/20.
//  Copyright © 2020 Sam Wu. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class TaskDetailViewController: UIViewController {
    let tableView = UITableView()
    
    let startButton = UIButton()
    
    static let headerIdentifier = "taskHeader"
    static let taskDetailIdentifier = "taskDetail"
    let task: Task
    
    init(with task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        tableView.reloadData()
        
        title = task.name
    }
    
    private func setUpView() {
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TaskDetailViewController.taskDetailIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = .systemBlue
        
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.textColor = .white
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(pushVideoView), for: .touchUpInside)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        view.addSubview(startButton)
        startButton.bringSubviewToFront(tableView)
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 150),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    
    @objc func pushVideoView() {
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .camera
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = self
        present(mediaUI, animated: true, completion: nil)
    }
}

extension TaskDetailViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {    dismiss(animated: true, completion: nil)
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
            else { return }
        
        let asset = AVAsset(url: url)
        let duration = CMTimeGetSeconds(asset.duration)
        dismiss(animated: true) { [weak self] in
            guard let self = self else {
                return
            }
            let evaluationVC = EvaluationViewController.init(with: self.task, videoURL: url, duration: duration)
            self.navigationController?.pushViewController(evaluationVC, animated: true)
        }
    }
    
}

// MARK: - UINavigationControllerDelegate

extension TaskDetailViewController: UINavigationControllerDelegate {
}


extension TaskDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Instructions"
        case 1:
            return "Penalties"
        default:
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return task.instructions.count
        case 1:
            return task.penalties.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskDetailViewController.taskDetailIdentifier) else {
            fatalError()
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = task.instructions[indexPath.item]
        case 1:
            cell.textLabel?.text = "● \(task.penalties[indexPath.item])"
        default:
            break
            
        }
        
        return cell
    }
}
