//
//  GameSummaryViewController.swift
//  WillowTreeNameGame
//
//  Created by Christopher Myers on 4/25/18.
//  Copyright © 2018 Dragoman Developers. All rights reserved.
//

import UIKit

class GameSummaryViewController: UIViewController {

    @IBOutlet weak var wtImageView: UIImageView!
    @IBOutlet weak var homeButtonOutlet: UIButton!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var averageTimeToCorrectLabel: UILabel!
    @IBOutlet weak var totalCorrect: UILabel!
    
    var scoreDataArray : [ScoreData]?
    
    // Computed vars for data summary display
    private var timeToCorrect : Double {
        let timeDifferenceSum = scoreDataArray?.reduce(0, { val1, val2 in
            (val1) + (val2.timeToCorrect - val2.timeStarted)
        }) ?? 0

        return (timeDifferenceSum / Double(scoreDataArray?.count ?? 1))
    }
    
    private var numberOfAttemptsPerGame : Double {
        let totalAttempts = scoreDataArray?.reduce(0, { initial, scoreData in
            initial + scoreData.attempts
        }) ?? 0
        return Double(totalAttempts / (scoreDataArray?.count ?? 1))
    }
    
    private var totalCorrectGames : Int {
        return scoreDataArray?.filter { $0.foundCorrectName == true }.count ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wtImageView.layer.cornerRadius = 15
        homeButtonOutlet.layer.cornerRadius = 15
        setSummaryLabels()
        
    }
    func injectScoreData(scoreDataArray : [ScoreData]) {
        self.scoreDataArray = scoreDataArray
    }
    
    private func setSummaryLabels() {
        averageTimeToCorrectLabel.text = "Avg. time to correct: " + String(format: "%.3f", timeToCorrect)
        attemptsLabel.text = "Avg. attempts per round: " + String(format: "%.3f", numberOfAttemptsPerGame)
        totalCorrect.text = "Total Correct Names: \(totalCorrectGames)"
    }

    @IBAction func homeTapped(_ sender: UIButton) {
        let homeVC = storyboard?.instantiateInitialViewController() as! HomeScreenViewController
        present(homeVC, animated: true)
    }
}