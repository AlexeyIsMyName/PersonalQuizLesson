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
    @IBOutlet var answerRangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnsers.count - 1)
            answerRangedSlider.maximumValue = answerCount
            answerRangedSlider.value = answerCount / 2
        }
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultsVC = segue.destination as? ResultsViewController {
            resultsVC.answers = chosenAnswers
        }
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleAnswerButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnsers[buttonIndex]
        chosenAnswers.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleAnswerSwitches, currentAnsers) {
            if multipleSwitch.isOn {
                chosenAnswers.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let index = lrintf(answerRangedSlider.value)
        chosenAnswers.append(currentAnsers[index])
        
        nextQuestion()
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
            showMultipleSteckView(with: currentAnsers)
        case .ranged:
            showRangedSteckView(with: currentAnsers)
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
        multipleAnswerStackView.isHidden = false
        
        for (label, answer) in zip(multipleAnswerLabels, answers) {
            label.text = answer.text
        }
    }
    
    private func showRangedSteckView(with answers: [Answer]) {
        rangedAnswerStackView.isHidden = false
        rangedAnswerLabels.first?.text = answers.first?.text
        rangedAnswerLabels.last?.text = answers.last?.text
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

