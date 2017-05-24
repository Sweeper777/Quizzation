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
    
    func toJSON() -> JSON {
        return [
            quizNameKey: name,
            questionsKey: questions.map { $0.toJSON() },
            gradeBoundariesKey: gradeBoundaries
        ]
    }
    
    static func from(json: JSON) -> Quiz? {
        guard let name = json[quizNameKey].string else { return nil }
        guard let arr = json[questionsKey].array else { return nil }
        guard let gradeBoundaries = (json[gradeBoundariesKey].array?.map { $0.int }.filter { $0 != nil }) else { return nil }
        let questions = arr.map { Question.from(json: $0) }.filter { $0 != nil }
        return Quiz(name: name, questions: questions as! [Question], gradeBoundaries: gradeBoundaries as! [Int])
    }
}
