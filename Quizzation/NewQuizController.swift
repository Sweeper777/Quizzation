import UIKit
import Eureka

class NewQuizController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ TextRow(tagName) {
            row in
            row.title = NSLocalizedString("Name", comment: "")
            row.cell.textField.textAlignment = .left
        }
        
        form +++ QuestionRow("test") {
            row in
            
            row.value = Question(questionText: "What is my name?", possibleAnswers: ["Sweeper"])
        }
    }
}