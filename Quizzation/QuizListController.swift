import UIKit
import Base64nl
import RealmSwift
import SwiftyJSON
import MGSwipeTableCell

extension Object {
    static func deleteAll(`in` realm: Realm) throws {
        let allObjects = realm.objects(self)
        try realm.write {
            realm.delete(allObjects)
        }
    }
}

class QuizListController: UITableViewController, MGSwipeTableCellDelegate {
    let realm = try? Realm()
    var quizzes: RealmSwift.Results<QuizData>!
    
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
        
        cell.rightButtons = [
            MGSwipeButton(title: "", icon: #imageLiteral(resourceName: "delete"), backgroundColor: UIColor(hex: "5abb5a")),
            MGSwipeButton(title: "", icon: #imageLiteral(resourceName: "export"), backgroundColor: UIColor(hex: "5abb5a")),
            MGSwipeButton(title: NSLocalizedString("Edit", comment: ""), backgroundColor: UIColor(hex: "5abb5a"))
        ]
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quizData = quizzes[indexPath.row]
        let quiz = Quiz.from(json: JSON(data: quizData.data! as Data))
        performSegue(withIdentifier: "doQuiz", sender: quiz)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let quiz = sender as? Quiz, let vc = (segue.destination as? UINavigationController)?.topViewController as? QuizController {
            vc.quiz = quiz
        }
        
        if let data = sender as? Data, let vc = (segue.destination as? UINavigationController)?.topViewController as? ExportController {
            vc.quizData = data
        }
    }
    
    @IBAction func unwindFromNewQuiz(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    @IBAction func importQuiz() {
        let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false))
        let textView = alert.addTextView()
        alert.addButton(NSLocalizedString("OK", comment: "")) {
            let base64String = textView.text!
            if let data = Data(base64Encoded: base64String), let _ = Quiz.from(json: JSON(data: data)) {
                try? self.realm?.write {
                    let quizData = QuizData()
                    quizData.data = data as NSData
                    self.realm?.add(quizData)
                }
                self.tableView.reloadData()
            } else {
                let errAlert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false))
                errAlert.addButton(NSLocalizedString("OK", comment: ""), action: {})
                _ = errAlert.showCustom(NSLocalizedString("Error", comment: ""), subTitle: NSLocalizedString("The code is not in the correct format!", comment: ""), color: .red, icon: UIImage())
            }
        }
        alert.addButton(NSLocalizedString("Cancel", comment: ""), action: {})
        
        textView.font = UIFont(name: "Courier New", size: 12)
        
        _ = alert.showCustom(NSLocalizedString("Import Quiz", comment: ""), subTitle: NSLocalizedString("Enter code in the box below", comment: ""), color: UIColor(hex: "5abb5a"), icon: #imageLiteral(resourceName: "import"))
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        let indexPath = tableView.indexPath(for: cell)!
        if index == 0 {
            performSegue(withIdentifier: "export", sender: quizzes[indexPath.row].data! as Data)
        }
        return true
    }
}

