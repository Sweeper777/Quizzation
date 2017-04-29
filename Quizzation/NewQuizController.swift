import UIKit
import Eureka

class NewQuizController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ TextRow(tagName) {
            row in
            row.title = NSLocalizedString("Name", comment: "")
            row.cell.textField.textAlignment = .left
        }
        
        
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done() {
        
    }
}
