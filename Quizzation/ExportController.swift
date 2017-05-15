import UIKit
import Eureka
import Base64nl

class ExportController: FormViewController {
    var quizData: Data!
    var base64String: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        base64String = quizData.base64EncodedString()
        
        form +++ Section(header: "", footer: NSLocalizedString("Share this and others can import the quiz using the code", comment: ""))
            <<< LabelRow(tagExportText) {
                row in
                row.cell.textLabel?.numberOfLines = 0
                row.cell.textLabel?.font = UIFont(name: "Courier New", size: 16)
                row.title = self.base64String
        }
            <<< ButtonRow() {
                row in
                row.title = "Share"
            }.onCellSelection {
                cell, row in
                let activityViewController = UIActivityViewController(activityItems: [self.base64String], applicationActivities: nil)
                self.navigationController?.present(activityViewController, animated: true)
        }
        
    }
    
    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }

}
