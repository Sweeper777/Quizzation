import SwiftyJSON
import Foundation

class Question {
    let type: QuestionType
    let questionText: String
    let possibleAnswers: [String]
    
    init(questionText: String, possibleAnswers: [String], hint: String? = nil) {
        self.type = .blank
        self.questionText = questionText
        self.possibleAnswers = possibleAnswers
    }
    
    init(questionText: String, answers: [MultipleChoiceAnswer], hint: String? = nil, requiresAllAnswers: Bool) {
        if requiresAllAnswers {
            self.type = .multipleMC
            self.possibleAnswers = [answers.map { $0.rawValue.description }.sorted().joined(separator: "")]
        } else {
            self.type = .singleMC
            self.possibleAnswers = answers.map { $0.rawValue.description }
        }
        self.questionText = questionText
    }
    
    private init(type: QuestionType, questionText: String, possibleAnswers: [String], hint: String?) {
        self.type = type
        self.questionText = questionText
        self.possibleAnswers = possibleAnswers
    }
    
    func toJSON() -> JSON {
        return [
            "type": type.rawValue,
            "questionText": questionText,
            "possibleAnswers": possibleAnswers,
        ]
    }
    
}

enum QuestionType: Int {
    case blank
    case singleMC
    case multipleMC
}

enum MultipleChoiceAnswer: Character {
    case a = "a"
    case b = "b"
    case c = "c"
    case d = "d"
}
