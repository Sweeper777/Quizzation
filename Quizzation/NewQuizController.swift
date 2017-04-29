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
        
        form +++ MultivaluedSection(multivaluedOptions: [.Delete, .Insert, .Reorder], header: NSLocalizedString("Questions", comment: ""), footer: "") {
            section in
            section.addButtonProvider = {
                _ in return ButtonRow() {
                    row in
                    row.title = NSLocalizedString("New Question", comment: "")
                }
            }
            
            section.multivaluedRowToInsertAt = {
                _ in return QuestionRow(tag: nil) {
                    row in
                    row.value = nil
                }
            }
        }
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done() {
        
    }
}
