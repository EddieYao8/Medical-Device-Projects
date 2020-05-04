//
//  EvaluationViewController.swift
//  Laparadome
//
//  Created by Sam Wu on 4/11/20.
//  Copyright © 2020 Sam Wu. All rights reserved.
//

import UIKit

class EvaluationViewController: UIViewController {
    
    static func formattedElapsedTime(for duration: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        let formattedString = formatter.string(from: TimeInterval(duration)) ?? ""
        
        return "Elapsed Time: \(formattedString)"
    }
    
    let task: Task
    let videoURL: URL
    let duration: Double
    
    let durationLabel = UILabel()
    let tableView = UITableView()
    
    let doneButton = UIButton()
    var correctAnswers = [Bool]()
    static let questionCellIdentifier = "questionCell"
    static let durationCellIdentifier = "durationCell"
    
    init(with task: Task, videoURL: URL, duration: Double) {
        self.task = task
        self.videoURL = videoURL
        self.duration = duration
        correctAnswers = Array(repeating: false, count: task.evaluationQuestions.count)
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
        
        tableView.register(EvaluationCell.self, forCellReuseIdentifier: EvaluationViewController.questionCellIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: EvaluationViewController.durationCellIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = .systemBlue
        
        doneButton.setTitle("Evaluate", for: .normal)
        doneButton.titleLabel?.textColor = .white
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(pushResultView), for: .touchUpInside)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        view.addSubview(doneButton)
        doneButton.bringSubviewToFront(tableView)
        NSLayoutConstraint.activate([
            doneButton.heightAnchor.constraint(equalToConstant: 150),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    
    @objc func pushResultView() {
        
        let passed = !correctAnswers.contains(false) && duration < task.timeLimit
        
        let resultVC = ResultViewController.init(with: task.name, passed: passed, duration: duration, videoURL: videoURL)
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
}


extension EvaluationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return task.evaluationQuestions.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell?
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: EvaluationViewController.durationCellIdentifier)
            cell?.textLabel?.text = EvaluationViewController.formattedElapsedTime(for: duration)
            cell?.textLabel?.textAlignment = .center
        case 1:
            
            guard let evalCell = tableView.dequeueReusableCell(withIdentifier: EvaluationViewController.questionCellIdentifier) as? EvaluationCell else {
                cell = nil
                break
            }
            let question = task.evaluationQuestions[indexPath.item]
            
            evalCell.questionLabel.text = question.question
            evalCell.responseSwitch.isOn = !question.expectedValue
            
            evalCell.switchHandler = { [weak self] bool in
                if question.expectedValue == bool {
                    self?.correctAnswers[indexPath.item] = true
                }
                
            }
            
            cell = evalCell
            
        default:
            cell = nil
        }
        
        return cell ?? UITableViewCell()
    }
}
