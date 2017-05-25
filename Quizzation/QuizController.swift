import UIKit
import Eureka

class QuizController: FormViewController {
    var quiz: Quiz!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index, question) in quiz.questions.enumerated() {
            let questionSection = Section(NSLocalizedString("Question", comment: "") + " \(index + 1)/\(quiz.questions.count)")
            questionSection <<< LabelRow() {
                row in
                row.cell.textLabel?.numberOfLines = 0
                row.title = question.questionText
            }
            form +++ questionSection
            switch question.type {
            case .blank:
                questionSection <<< TextRow("answer\(index)") {
                    row in
                    row.title = NSLocalizedString("Answer", comment: "")
                    row.cell.textField.placeholder = NSLocalizedString("Type here", comment: "")
                }
            case .multipleMC:
                questionSection <<< MultiSelectSegmentedRow("answer\(index)") {
                    row in
                    row.title = NSLocalizedString("Answer", comment: "")
                }
            case .singleMC:
                questionSection <<< SingleSelectSegmentedRow("answer\(index)") {
                    row in
                    row.title = NSLocalizedString("Answer", comment: "")
                }
            }
            if let hint = question.hint {
                questionSection <<< ButtonRow() {
                    row in
                    row.title = NSLocalizedString("Show Hint", comment: "")
                }
                    .onCellSelection {
                    cell, row in
                    row.hidden = true
                    row.evaluateHidden()
                    questionSection <<< LabelRow() {
                        row in
                        row.title = NSLocalizedString("Hint:", comment: "") + " " + hint
                    }
                }
            }
        }
    }

    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit() {
        var correctAnswers = 0
        var hintUsed = 0
        for (index, question) in quiz.questions.enumerated() {
            let row = form.rowBy(tag: "answer\(index)")!
            switch question.type {
            case .blank:
                guard let answer = row.baseValue as? String else { continue }
                if question.possibleAnswers.contains(answer) {
                    correctAnswers += 1
                }
            case .multipleMC:
                guard let answer = ((row.baseValue as? NSMutableArray)?.map { $0 as? String }) else { continue }
                if Set(question.possibleAnswers) == Set(answer.filter { $0 != nil }.map { $0! }) {
                    correctAnswers += 1
                }
            case .singleMC:
                guard let answer = row.baseValue as? Character else { continue }
                if question.possibleAnswers.contains(answer.description) {
                    correctAnswers += 1
                }
            }
            if row.section!.last! is LabelRow {
                hintUsed += 1
            }
        }
        performSegue(withIdentifier: "submit", sender: Results(quiz: quiz, correctAnswers: correctAnswers, hintUsed: hintUsed))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = (segue.destination as? UINavigationController)?.topViewController as? QuizResultsController, let results = sender as? Results {
            vc.correctAnswers = results.correctAnswers
            vc.hintUsed = results.hintUsed
            vc.quiz = results.quiz
        }
    }
}
