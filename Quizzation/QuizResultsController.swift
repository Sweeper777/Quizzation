import UIKit
import Eureka

class QuizResultsController: FormViewController {
    var correctAnswers: Int!
    var hintUsed: Int!
    var quiz: Quiz!
    var wrongAnswers: [WronglyAnsweredQuestion]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ LabelRow() {
            row in
            row.cellStyle = .value1
            row.title = NSLocalizedString("Number of Questions", comment: "")
            row.value = "\(quiz.questions.count)"
        }
        <<< LabelRow() {
            row in
            row.cellStyle = .value1
            row.title = NSLocalizedString("Correct Answers", comment: "")
            row.value = "\(correctAnswers!)"
        }
        <<< LabelRow() {
            row in
            row.cellStyle = .value1
            row.title = NSLocalizedString("Hint(s) Used", comment: "")
            row.value = "\(hintUsed!)"
        }
        <<< LabelRow() {
            row in
            row.cellStyle = .value1
            row.title = NSLocalizedString("Percentage", comment: "")
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 2
            row.value = "\(formatter.string(from: (Double(correctAnswers) / Double(quiz.questions.count) * 100) as NSNumber)!)%"
        }
        <<< LabelRow() {
            row in
            row.cellStyle = .value1
            row.title = NSLocalizedString("Grade", comment: "")
            row.value = quiz.grade(percentage: Double(correctAnswers) / Double(quiz.questions.count))
        }
        if wrongAnswers.isNotEmpty {
            form +++ ButtonRow() {
                row in
                row.title = NSLocalizedString("Show Wrongly Answered Questions", comment: "")
                row.cell.tintColor = UIColor(hex: "3b7b3b")
                }.onCellSelection {
                    cell, row in
                    row.hidden = true
                    row.evaluateHidden()
                    self.showWronglyAnsweredQuestions()
            }
        }
    }
    
    func showWronglyAnsweredQuestions() {
        let section = Section()
        form +++ section
        for question in wrongAnswers {
            section <<< LabelRow() {
                row in
                row.cell.textLabel?.numberOfLines = 0
                row.title = question.questionText
            }
            <<< LabelRow() {
                row in
                row.cellStyle = .value1
                row.title = NSLocalizedString("Correct Answer(s)", comment: "")
                row.value = question.correctAnswers.joined(separator: ", ")
            }
            <<< LabelRow() {
                row in
                row.cellStyle = .value1
                row.title = NSLocalizedString("Your Answer", comment: "")
                row.value = question.yourAnswer
            }
        }
    }
    
    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
}
