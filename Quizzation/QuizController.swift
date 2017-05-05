import UIKit
import Eureka

class QuizController: FormViewController {
    var quiz: Quiz!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit() {
        
    }
}
