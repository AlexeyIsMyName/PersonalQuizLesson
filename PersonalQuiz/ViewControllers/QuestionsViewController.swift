//
//  QuestionsViewController.swift
//  PersonalQuiz
//
//  Created by ALEKSEY SUSLOV on 22.07.2022.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionProgressView: UIProgressView!
    @IBOutlet var answerRangedSlider: UISlider!
    
    @IBOutlet var singleAnswerStackView: UIStackView!
    @IBOutlet var multipleAnswerStackView: UIStackView!
    @IBOutlet var rangedAnswerStackView: UIStackView!
    
    @IBOutlet var singleAnswerButtons: [UIButton]!
    
    @IBOutlet var multipleAnswerLabels: [UILabel]!
    @IBOutlet var multipleAnswerSwitches: [UISwitch]!
    
    @IBOutlet var rangedAnswerLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func multipleAnswerButtonPressed() {
    }
    
    @IBAction func rangedAnswerButtonPressed() {
    }
}

// MARK: - Private Methods
extension QuestionsViewController {
    private func updateUI() {
        for stackView in [singleAnswerStackView, multipleAnswerStackView, rangedAnswerStackView] {
            stackView?.isHidden = true
        }
    }
}

