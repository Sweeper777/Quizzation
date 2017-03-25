import UIKit

class QuizListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test2()
    }
    
    func test1() {
        let testQuestion = Question(questionText: "Hello", possibleAnswers: ["a", "b"])
        print(testQuestion.toJSON())
    }
    
    func test2() {
        let testQuestion = Question(questionText: "笔在桌子___", possibleAnswers: ["上", "下"])
        let data = try! testQuestion.toJSON().rawData()
        print(String(data: data, encoding: .utf8)!)
    }
}

