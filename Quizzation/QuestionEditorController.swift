import UIKit
import Eureka
import SwiftyUtils
import SCLAlertView

class QuestionEditorController: FormViewController, TypedRowControllerType {
    typealias RowValue = Question
    var onDismissCallback: ((UIViewController) -> ())?
    var row: RowOf<Question>!
    var completionCallback: ((UIViewController) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myNav: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.width, height: 44))
        myNav.barTintColor = #colorLiteral(red: 0.3529411765, green: 0.7333333333, blue: 0.3529411765, alpha: 1)
        myNav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.view.addSubview(myNav)
        let cancelItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        cancelItem.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let doneItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        doneItem.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let navigItem: UINavigationItem = UINavigationItem(title: NSLocalizedString("Question Editor", comment: ""))
        navigItem.rightBarButtonItem = doneItem
        navigItem.leftBarButtonItem = cancelItem
        myNav.items = [navigItem]
        
        tableView.contentInset = UIEdgeInsets(top: 44 + UIScreen.screenStatusBarHeight, left: 0, bottom: 0, right: 0)
        
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
            section.tag = tagFIBAnswersSection
            
            if row.value?.type == .blank {
                for answer in row.value?.possibleAnswers ?? [] {
                    section <<< TextRow() {
                        row in
                        row.cell.textField.placeholder = NSLocalizedString("Answer", comment: "")
                        row.value = answer
                    }
                }
            }
        }
        
        form +++ Section(NSLocalizedString("answers", comment: "")) {
            section in
            section.tag = tagMCSingleAnswerSection
            
            section.hidden = Condition.function([tagQuestionType]) {
                form in
                let typeRow: RowOf<QuestionType> = form.rowBy(tag: tagQuestionType)!
                return typeRow.value != .singleMC
            }
        }
        
        for choice in [MultipleChoiceAnswer.a, .b, .c, .d] {
            form.sectionBy(tag: tagMCSingleAnswerSection)! <<< CheckRow(tagMCSingleAnswer + choice.rawValue.description) {
                row in
                row.title = choice.rawValue.description
                if self.row.value?.type == .singleMC {
                    row.value = self.row.value!.possibleAnswers.contains(choice.rawValue.description)
                }
            }
        }
        
        form +++ Section(NSLocalizedString("answers", comment: "")) {
            section in
            section.tag = tagMCMultipleAnswersSection
            
            section.hidden = Condition.function([tagQuestionType]) {
                form in
                let typeRow: RowOf<QuestionType> = form.rowBy(tag: tagQuestionType)!
                return typeRow.value != .multipleMC
            }
        }
        
        for choice in [MultipleChoiceAnswer.a, .b, .c, .d] {
            form.sectionBy(tag: tagMCMultipleAnswersSection)! <<< CheckRow(tagMCMultipleAnswers + choice.rawValue.description) {
                row in
                row.title = choice.rawValue.description
                if self.row.value?.type == .multipleMC {
                    row.value = self.row.value!.possibleAnswers.contains(choice.rawValue.description)
                }
            }
        }
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func done() {
        func error() {
            let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton:false))
            alert.addButton(NSLocalizedString("OK", comment: ""), action: {})
            alert.showError(NSLocalizedString("Error", comment: ""), subTitle: NSLocalizedString("Please add at least one answer!", comment: ""))
        }
        
        let values = form.values(includeHidden: false)
        let answersSection: Section
        switch values[tagQuestionType] as! QuestionType {
        case .blank:
            answersSection = form.sectionBy(tag: tagFIBAnswersSection)!
        case .multipleMC:
            answersSection = form.sectionBy(tag: tagMCMultipleAnswersSection)!
        case .singleMC:
            answersSection = form.sectionBy(tag: tagMCSingleAnswerSection)!
        }
        
        let questionType = values[tagQuestionType] as! QuestionType
        let questionText = (values[tagQuestionText] as? String) ?? ""
        let hint = values[tagHint] as? String
        var possibleAnswers = [String]()
        for row in answersSection {
            if row.baseValue is String {
                possibleAnswers.append(row.baseValue as! String)
            } else if row.baseValue is Bool {
                possibleAnswers.append(row.title!)
            }
        }
        
        if possibleAnswers.isEmpty {
            error()
            return
        }
        
        self.row.value = Question(type: questionType, questionText: questionText, possibleAnswers: possibleAnswers, hint: hint)
        dismiss(animated: true, completion: nil)
    }
}
