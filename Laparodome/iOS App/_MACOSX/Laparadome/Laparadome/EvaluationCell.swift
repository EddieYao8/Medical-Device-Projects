//
//  EvaluationCell.swift
//  Laparadome
//
//  Created by Sam Wu on 4/11/20.
//  Copyright © 2020 Sam Wu. All rights reserved.
//

import UIKit

class EvaluationCell: UITableViewCell {
    
    let questionLabel = UILabel()
    let responseSwitch = UISwitch()
    
    var switchHandler: ((Bool) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func valueChanged() {
        switchHandler?(responseSwitch.isOn)
    }
    
    func setUpView() {
        questionLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        questionLabel.numberOfLines = 0
        
        responseSwitch.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        
        let stackView = UIStackView(arrangedSubviews: [questionLabel, responseSwitch])
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            responseSwitch.widthAnchor.constraint(equalToConstant: 60),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
}
