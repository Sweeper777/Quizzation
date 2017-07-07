import SwiftyJSON
import Foundation
import ObjectMapper

class Question: Equatable, ImmutableMappable {
    let type: QuestionType
    let questionText: String
    let possibleAnswers: [String]
    let hint: String?
    
    init(type: QuestionType, questionText: String, possibleAnswers: [String], hint: String?) {
        self.type = type
        self.questionText = questionText
        self.possibleAnswers = possibleAnswers
        self.hint = hint
    }
    
    required init(map: Map) throws {
        type = try map.value(questionTypeKey)
        questionText = try map.value(questionTextKey)
        possibleAnswers = try map.value(possibleAnswersKey)
        hint = try? map.value(hintKey)
    }
    
    func mapping(map: Map) {
        type >>> map[questionTypeKey]
        questionText >>> map[questionTextKey]
        possibleAnswers >>> map[possibleAnswersKey]
        hint >>> map[hintKey]
    }
    
    static func ==(lhs: Question, rhs: Question) -> Bool {
        return JSON(lhs.toJSON()) == JSON(rhs.toJSON())
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
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
}
