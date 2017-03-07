//
//  ScoreViewController.swift
//  AwesomeBoggle
//
//  Created by mitch.harris on 2/23/17.
//  Copyright © 2017 mitch.harris. All rights reserved.
//

import Foundation
import UIKit

class ScoreViewController: UIViewController {
    private let scoreView: ScoreView
    
    init(scoreView: ScoreView = ScoreView()){
        self.scoreView = scoreView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
