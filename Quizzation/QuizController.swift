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
            case .multipleMC:
            case .singleMC:
            }
        }
    }

    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit() {
        
    }
}
