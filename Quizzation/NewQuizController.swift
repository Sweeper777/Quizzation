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
        
        form +++ QuestionRow(tag: "test") {
            row in
            
            row.value = Question(type: .blank, questionText: "What is my name?", possibleAnswers: ["Sweeper", "Sweeper777"], hint: nil)
        }
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done() {
        
    }
}
