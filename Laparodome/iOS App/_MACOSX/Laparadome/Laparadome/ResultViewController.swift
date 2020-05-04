//
//  ResultViewController.swift
//  Laparadome
//
//  Created by Sam Wu on 4/11/20.
//  Copyright © 2020 Sam Wu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    let passed: Bool
    let duration: Double
    let videoURL: URL
    
    let durationLabel = UILabel()
    let passedLabel = UILabel()
    let saveAndQuitButton = UIButton()
    let quitButton = UIButton()
    
    init(with title: String, passed: Bool, duration: Double, videoURL: URL) {
        self.passed = passed
        self.duration = duration
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Task Result: \(title)"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        
        let stackView = UIStackView(arrangedSubviews: [durationLabel, passedLabel, saveAndQuitButton, quitButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        durationLabel.text = EvaluationViewController.formattedElapsedTime(for: duration)
        durationLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        durationLabel.numberOfLines = 0
        
        passedLabel.text = passed ? "Passed!" : "Failed"
        passedLabel.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        passedLabel.textColor = passed ? .systemGreen : .red
        passedLabel.textAlignment = .center
        saveAndQuitButton.setTitle("Save Video and Return Home", for: .normal)
        saveAndQuitButton.addTarget(self, action: #selector(saveAndQuit), for: .touchUpInside)
        saveAndQuitButton.backgroundColor = .systemBlue

        quitButton.setTitle("Return Home", for: .normal)
        quitButton.addTarget(self, action: #selector(quit), for: .touchUpInside)
        quitButton.backgroundColor = .systemRed
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            saveAndQuitButton.heightAnchor.constraint(equalToConstant: 80),
            quitButton.heightAnchor.constraint(equalToConstant: 80),

            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
    }
    
    @objc func saveAndQuit() {
        UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, nil, nil, nil)
        quit()
    }
    
    @objc func quit() {
        navigationController?.popToRootViewController(animated: true)
    }
}
