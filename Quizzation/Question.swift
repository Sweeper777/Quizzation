import SwiftyJSON
import Foundation
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
