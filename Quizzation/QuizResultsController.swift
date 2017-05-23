import UIKit
import Eureka

class QuizResultsController: FormViewController {
    var correctAnswers: Int!
    var hintUsed: Int!
    var quiz: Quiz!
    
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
    }
    
    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
}
