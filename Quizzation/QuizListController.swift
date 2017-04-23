import UIKit
import Base64nl
import RealmSwift
import SwiftyJSON

class QuizListController: UITableViewController {
    let realm = try? Realm()
    var quizzes: Results<QuizData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.navigationController?.navigationBar.height)
        quizzes = realm?.objects(QuizData.self)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let quizData = quizzes[indexPath.row].data!
        let json = JSON(data: quizData as Data)
        cell.textLabel?.text = json[quizNameKey].string
        return cell
    }
}

