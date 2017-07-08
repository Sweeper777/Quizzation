import Foundation
import SwiftyJSON
import ObjectMapper

class Quiz : ImmutableMappable {
    let name: String
    let gradeBoundaries: [Int]
    let questions: [Question]
    
    init(name: String, questions: [Question], gradeBoundaries: [Int]) {
        self.name = name
        self.questions = questions
        self.gradeBoundaries = gradeBoundaries
    }
    
    required init(map: Map) throws {
        name = try map.value(quizNameKey)
        gradeBoundaries = try map.value(gradeBoundariesKey)
        questions = try map.value(questionsKey)
    }
    
    func mapping(map: Map) {
        name >>> map[quizNameKey]
        gradeBoundaries >>> map[gradeBoundariesKey]
        questions >>> map[questionsKey]
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
