//
//  WordDetailViewController.swift
//  AwesomeBoggle
//
//  Created by mitch.harris on 2/23/17.
//  Copyright © 2017 mitch.harris. All rights reserved.
//

import Foundation
import UIKit

class WordDetailViewController: UIViewController {
    let wordDetailView: WordDetailView
    let boggleModel: BoggleModel
    
    init(wordDetailView: WordDetailView = WordDetailView(), boggleModel: BoggleModel = BoggleModel()) {
        
        self.wordDetailView = wordDetailView
        self.boggleModel = boggleModel
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
