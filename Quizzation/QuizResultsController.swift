import UIKit
import Eureka

class QuizResultsController: FormViewController {
    var correctAnswers: Int!
    var hintUsed: Int!
    var quiz: Quiz!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
}
