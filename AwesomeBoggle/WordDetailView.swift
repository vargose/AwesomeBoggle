//
//  WordDetailView.swift
//  AwesomeBoggle
//
//  Created by mitch.harris on 2/23/17.
//  Copyright © 2017 mitch.harris. All rights reserved.
//

import Foundation
import UIKit

protocol WordDetailViewProtocol: class {
    func modalTapped()
}

class WordDetailView: UIView {
    
    weak var delegate: WordDetailViewProtocol?
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .green
        
        let modalButton = UIButton()
        modalButton.setTitle("modal", for: .normal)
        modalButton.addTarget(self, action: #selector(modalTapped), for: .touchUpInside)
        
        self.addSubview(modalButton)
        modalButton.translatesAutoresizingMaskIntoConstraints = false
        modalButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        modalButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        modalButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        modalButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func modalTapped() {
        self.delegate?.modalTapped()
    }
}
