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
    
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var chosenAnswers: [Answer] = []
    private var currentAnsers: [Answer] {
        questions[questionIndex].answers
    }
    
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
        guard let buttonIndex = singleAnswerButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnsers[buttonIndex]
        chosenAnswers.append(currentAnswer)
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
    }
    
    @IBAction func rangedAnswerButtonPressed() {
    }
}

// MARK: - Private Methods
extension QuestionsViewController {
    private func updateUI() {
        // Hide everything
        for stackView in [singleAnswerStackView, multipleAnswerStackView, rangedAnswerStackView] {
            stackView?.isHidden = true
        }
        
        // get current question
        let currentQuestion = questions[questionIndex]
        
        // set current question for question label
        questionLabel.text = currentQuestion.text
        
        // calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // set progress for questionProgressView
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // set navigation title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // show stacks corresponding to question type
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnsers)
        case .multiple:
            break
        case .ranged:
            break
        }
    }
    
    /// Show single stack view
    ///
    /// - Parameter answers: array of answers
    ///
    /// Show single stack view with answers for current question
    private func showSingleStackView(with answers: [Answer]) {
        singleAnswerStackView.isHidden = false
        
        for (button, answer) in zip(singleAnswerButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func showMultipleSteckView(with answers: [Answer]) {
        
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}

