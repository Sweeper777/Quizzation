import UIKit
import Base64nl
import RealmSwift
import SwiftyJSON
import MGSwipeTableCell

class QuizListController: UITableViewController, MGSwipeTableCellDelegate {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MGSwipeTableCell
        let quizData = quizzes[indexPath.row].data!
        let json = JSON(data: quizData as Data)
        cell.textLabel?.text = json[quizNameKey].string
        
        cell.rightButtons = [MGSwipeButton(title: NSLocalizedString("Edit", comment: ""), backgroundColor: .green)]
        cell.delegate = self
        
        return cell
    }
    @IBAction func unwindFromNewQuiz(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        return true
    }
}

