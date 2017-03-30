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
    
    static func from(json: JSON) -> Quiz? {
        guard let name = json[quizNameKey].string else { return nil }
        guard let arr = json[questionsKey].array else { return nil }
        let questions = arr.map { Question.from(json: $0) }.filter { $0 != nil }
        return Quiz(name: name, questions: questions as! [Question])
    }
}
