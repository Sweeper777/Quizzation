import UIKit
import Eureka
import SCLAlertView

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
                }.onChange {
                    row in
                    row.title = row.value?.type.description ?? NSLocalizedString("Blank Question", comment: "")
                }
            }
            section.tag = tagQuestionsSection
            
        }
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done() {
        let values = form.values()
        if let name = values[tagName] as? String {
            if name.trimmed() == "" {
                let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton:false))
                alert.addButton(NSLocalizedString("OK", comment: ""), action: {})
                alert.showError(NSLocalizedString("Error", comment: ""), subTitle: NSLocalizedString("Name cannot be blank!", comment: ""))
                return
            } else {
                let section = form.sectionBy(tag: tagQuestionsSection)!
                var questions = [Question]()
                for row in section {
                    if let value = row.baseValue as? Question {
                        questions.append(value)
                    }
                }
                if questions.isEmpty {
                    let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton:false))
                    alert.addButton(NSLocalizedString("OK", comment: ""), action: {})
                    alert.showError(NSLocalizedString("Error", comment: ""), subTitle: NSLocalizedString("Please add at least one question!", comment: ""))
                    return
                }
                
            }
        } else {
            let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton:false))
            alert.addButton(NSLocalizedString("OK", comment: ""), action: {})
            alert.showError(NSLocalizedString("Error", comment: ""), subTitle: NSLocalizedString("Name cannot be blank!", comment: ""))
            return
        }
        
    }
}
