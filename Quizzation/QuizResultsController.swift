import UIKit
import Eureka

class QuizResultsController: FormViewController {
    var correctAnswers: Int!
    var noOfQuestions: Int!
    var hintUsed: Int!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
}
