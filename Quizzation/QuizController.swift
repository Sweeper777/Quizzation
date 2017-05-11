import UIKit
import Eureka

class QuizController: FormViewController {
    var quiz: Quiz!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index, question) in quiz.questions.enumerated() {
            let questionSection = Section(NSLocalizedString("Question", comment: "") + " \(index)/\(quiz.questions.count)")
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
            case .singleMC:
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
        
    }
}
