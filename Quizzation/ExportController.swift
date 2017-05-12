import UIKit
import Eureka
import Base64nl

class ExportController: FormViewController {
    var quizData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section(header: "", footer: NSLocalizedString("Share this and others can import the quiz using the code", comment: ""))
            <<< LabelRow(tagExportText) {
                row in
                row.cell.textLabel?.numberOfLines = 0
                row.cell.textLabel?.font = UIFont(name: "Courier New", size: 16)
                row.title = quizData.base64EncodedString()
        }
            <<< ButtonRow() {
                row in
                row.title = "Share"
        }
    }

}
