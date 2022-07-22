//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by ALEKSEY SUSLOV on 22.07.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var definitionAnswerLabel: UILabel!
    
    var answers: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        updateResult()
    }

}

// MARK: - Private Methods
extension ResultsViewController {
    private func updateResult() {
        var countAnimals: [AnimalType: Int] = [:]
        let animals = answers.map { $0.type }
        
        animals.forEach { animal in
            countAnimals[animal] = (countAnimals[animal] ?? 0) + 1
        }
        
        let sortedAnimals = countAnimals.sorted { $0.value > $1.value }
        
        guard let animalResult = sortedAnimals.first?.key else { return }
        
        updateUI(with: animalResult)
    }
    
    private func updateUI(with animal: AnimalType) {
        answerLabel.text = "Вы - \(animal.rawValue)"
        definitionAnswerLabel.text = animal.definition
    }
}
