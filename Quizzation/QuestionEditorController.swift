import UIKit
import Eureka

class QuestionEditorController: FormViewController, TypedRowControllerType {
    typealias RowValue = Question
    var onDismissCallback: ((UIViewController) -> ())?
    var row: RowOf<Question>!
    var completionCallback: ((UIViewController) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myNav: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320,height: 50))
        myNav.barTintColor = #colorLiteral(red: 0.3529411765, green: 0.7333333333, blue: 0.3529411765, alpha: 1)
        myNav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.view.addSubview(myNav)
        let cancelItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        cancelItem.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let doneItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        doneItem.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let navigItem: UINavigationItem = UINavigationItem(title: NSLocalizedString("Question Editor", comment: ""))
        navigItem.rightBarButtonItem = doneItem
        navigItem.leftBarButtonItem = cancelItem
        myNav.items = [navigItem]
        
        form +++ PickerInlineRow<QuestionType>(tagQuestionType) {
            row in
            row.options = [.blank, .singleMC, .multipleMC]
            row.value = self.row.value?.type ?? .blank
            row.title = NSLocalizedString("Type", comment: "")
        }
        
        form +++ Section(NSLocalizedString("question", comment: ""))
            
        <<< TextAreaRow(tagQuestionText) {
            row in
            row.value = self.row.value?.questionText ?? ""
        }
            
        <<< TextRow(tagHint) {
            row in
            row.title = NSLocalizedString("Hint", comment: "")
            row.cell.textField.placeholder = NSLocalizedString("Optional", comment: "")
            row.value = self.row.value?.hint ?? ""
        }
        
        form +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: NSLocalizedString("answers", comment: ""), footer: "") {
            section in
            section.hidden = Condition.function([tagQuestionType]) {
                form in
                let typeRow: RowOf<QuestionType> = form.rowBy(tag: tagQuestionType)!
                return typeRow.value != .blank
            }
            
            section.addButtonProvider = { _ in
                return ButtonRow() {
                    row in
                    row.title = NSLocalizedString("Add New Answer", comment: "")
                }
            }
            
            section.multivaluedRowToInsertAt = {
                index in
                return TextRow() {
                    row in
                    row.cell.textField.placeholder = NSLocalizedString("Answer", comment: "")
                }
            }
        }
    }
    
    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }
}
