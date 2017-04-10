import UIKit
import Eureka

class QuestionEditorController: FormViewController, TypedRowControllerType {
    typealias RowValue = Question
    var onDismissCallback: ((UIViewController) -> ())?
    var row: RowOf<Question>!
    var completionCallback: ((UIViewController) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ PickerInlineRow<QuestionType>(tagQuestionType) {
            row in
            row.options = [.blank, .singleMC, .multipleMC]
            row.value = .blank
            row.title = NSLocalizedString("Type", comment: "")
        }
        
        form +++ Section(NSLocalizedString("question", comment: ""))
            
        <<< TextAreaRow(tagQuestionText) {
            row in
        }
        
        <<< TextRow(tagHint) {
            row in
            row.title = NSLocalizedString("Hint", comment: "")
            row.cell.textField.placeholder = NSLocalizedString("Optional", comment: "")
        }
        
        form +++ Section(NSLocalizedString("answers", comment: "")) {
            section in
            section.hidden = Condition.function([tagQuestionType]) {
                form in
                let typeRow: RowOf<QuestionType> = form.rowBy(tag: tagQuestionType)!
                return typeRow.value != .blank
            }
        }
    }
    
    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
}
