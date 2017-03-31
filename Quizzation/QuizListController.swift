import UIKit

class QuizListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test2()
    }
    
    func test1() {
        let testQuestion1 = Question(questionText: "What is my name?", possibleAnswers: ["Sweeper", "Sweper", "Swooper", "Swaaper"])
        let testQuestion2 = Question(questionText: "What is his name?", possibleAnswers: ["Sweeper", "Sweper", "Swooper", "Swaaper"])
        let testQuestion3 = Question(questionText: "What is her name?", possibleAnswers: ["Sweeper", "Sweper", "Swooper", "Swaaper"])
        let testQuestion4 = Question(questionText: "What is your name?", possibleAnswers: ["Sweeper", "Sweper", "Swooper", "Swaaper"])
        let quiz = Quiz(name: "My Quiz", questions: [testQuestion1, testQuestion2, testQuestion3, testQuestion4])
        let data = try! quiz.toJSON().rawData()
        
        print(data.base64EncodedString().characters.count)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func test2() {
        let testQuestion = Question(questionText: "笔在桌子___", possibleAnswers: ["上", "下"])
        let data = try! testQuestion.toJSON().rawData()
        print(String(data: data, encoding: .utf8)!)
    }
}

