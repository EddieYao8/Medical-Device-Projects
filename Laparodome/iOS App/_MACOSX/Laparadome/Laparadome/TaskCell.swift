//
//  TaskCell.swift
//  Laparadome
//
//  Created by Sam Wu on 4/11/20.
//  Copyright © 2020 Sam Wu. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    let taskNumberLabel = UILabel()
    let taskNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()

    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        taskNumberLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        taskNameLabel.font = UIFont.systemFont(ofSize: 35, weight: .regular)
        
        let stackView = UIStackView(arrangedSubviews: [taskNumberLabel, taskNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 6
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
}
