struct Results {
    let quiz: Quiz
    let correctAnswers: Int
    let hintUsed: Int
    let wrongAnswers: [WronglyAnsweredQuestion]
}

struct WronglyAnsweredQuestion {
    let questionText: String
    let correctAnswers: [String]
    let yourAnswer: String
}
