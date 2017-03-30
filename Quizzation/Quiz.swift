import Foundation
import SwiftyJSON

class Quiz {
    let name: String
    let questions: [Question]
    
    init(name: String, questions: [Question]) {
        self.name = name
        self.questions = questions
    }
    
    func toJSON() -> JSON {
        return [
            quizNameKey: name,
            questionsKey: questions.map { $0.toJSON() }
        ]
    }
    
}
