import UIKit
import Eureka

final class QuestionRow: SelectorRow<PushSelectorCell<Question>, QuestionEditorController> {
    required init(tag: String?, _ initializer: ((QuestionRow) -> ())) {
        super.init(tag: tag)
        initializer(self)
        title = self.value?.type.description
        presentationMode = PresentationMode.segueName(segueName: "showQuestionEditor", onDismiss: {
            _ in
        })
        displayValueFor = {
            $0?.questionText ?? NSLocalizedString("Unnamed", comment: "")
        }
    }
    required convenience init(tag: String?) {
        self.init(tag: tag)
    }
}
