import UIKit
import Eureka

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func test1() {
        let testQuestion = Question(questionText: "Hello", possibleAnswers: ["a", "b"])
        print(testQuestion.toJSON())
    }
    
    }
}

