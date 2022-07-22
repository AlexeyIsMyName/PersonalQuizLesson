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
    
    var chosenAnswers: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

}

extension ResultsViewController {
    private func updateUI() {
        let animalType = getAnimalType()
        answerLabel.text = "Вы - \(animalType?.rawValue ?? "🐶")"
        definitionAnswerLabel.text = animalType?.definition
    }
    
    private func getAnimalType() -> AnimalType? {
        var countAnimals: [AnimalType: Int] = [:]
        
        chosenAnswers.forEach { answer in
            countAnimals[answer.type] = (countAnimals[answer.type] ?? 0) + 1
        }
        
        let sortedAnimals = countAnimals.sorted { $0.value > $1.value }
        
        return sortedAnimals.first?.key
    }
}
