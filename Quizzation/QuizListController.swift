import UIKit
import Base64nl
import RealmSwift
import SwiftyJSON

class QuizListController: UITableViewController {
    let realm = try? Realm()
    var quizzes: Results<QuizData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizzes = realm?.objects(QuizData.self)
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

