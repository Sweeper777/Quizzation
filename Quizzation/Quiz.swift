import Foundation
import SwiftyJSON

class Quiz {
    let name: String
    let gradeBoundaries: [Int]
    let questions: [Question]
    
    init(name: String, questions: [Question], gradeBoundaries: [Int]) {
        self.name = name
        self.questions = questions
        self.gradeBoundaries = gradeBoundaries
    }
    
    }
    
    }
    
    func grade(percentage: Double) -> String {
        var retval = "E"
        let grades = ["D", "C", "B", "A", "A*"]
        for (index, grade) in gradeBoundaries.enumerated() {
            if Int(percentage * 100) >= grade {
                retval = grades[index]
            } else {
                return retval
            }
        }
        return "A*"
    }
}
