import UIKit
import Eureka

class QuestionCell: LabelCellOf<Question> {
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func setup() {
        super.setup()
        selectionStyle = .gray
        accessoryType = .disclosureIndicator
    }
}

final class QuestionRow: Row<QuestionCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = {
            $0?.questionText ?? NSLocalizedString("Unnamed", comment: "")
        }
    }
}
