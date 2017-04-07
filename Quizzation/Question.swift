import SwiftyJSON
import Foundation

class Question: Equatable {
    let type: QuestionType
    let questionText: String
    let possibleAnswers: [String]
    let hint: String?
    
    init(questionText: String, possibleAnswers: [String], hint: String? = nil) {
        self.type = .blank
        self.questionText = questionText
        self.possibleAnswers = possibleAnswers
        self.hint = hint
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
        self.hint = hint
    }
    
    private init(type: QuestionType, questionText: String, possibleAnswers: [String], hint: String?) {
        self.type = type
        self.questionText = questionText
        self.possibleAnswers = possibleAnswers
        self.hint = hint
    }
    
    func toJSON() -> JSON {
        return [
            questionTypeKey: type.rawValue,
            questionTextKey: questionText,
            possibleAnswersKey: possibleAnswers,
            hintKey: hint as Any
        ]
    }
    
    static func from(json: JSON) -> Question? {
        guard let type = json["type"].int else { return nil }
        guard let questionText = json[questionTypeKey].string else { return nil }
        guard let possibleAnswersJSON = json[possibleAnswersKey].array else { return nil }
        let possibleAnswers = possibleAnswersJSON.map { $0.string }.filter { $0 != nil }.map { $0! }
        if possibleAnswers.isEmpty {
            return nil
        }
        
        return Question(type: QuestionType(rawValue: type)!, questionText: questionText, possibleAnswers: possibleAnswers, hint: json[hintKey].string)
    }
    
    static func ==(lhs: Question, rhs: Question) -> Bool {
        return lhs.toJSON() == rhs.toJSON()
    }
}

enum QuestionType: Int, CustomStringConvertible {
    case blank
    case singleMC
    case multipleMC
    
    var description: String {
        switch self {
        case .blank:
            return NSLocalizedString("Fill In the Blank", comment: "")
        case .singleMC:
            return NSLocalizedString("Multiple Choice (Single Answer)", comment: "")
        case .multipleMC:
            return NSLocalizedString("Multiple Choice (Multiple Answers)", comment: "")
        }
    }
}

enum MultipleChoiceAnswer: Character {
    case a = "a"
    case b = "b"
    case c = "c"
    case d = "d"
}
