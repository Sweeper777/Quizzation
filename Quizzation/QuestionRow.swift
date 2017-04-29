import UIKit
import Eureka

final class QuestionRow: SelectorRow<PushSelectorCell<Question>, QuestionEditorController>, RowType {
    required init(tag: String?, _ initializer: ((QuestionRow) -> ())) {
        super.init(tag: tag)
        initializer(self)
        title = self.value?.type.description ?? NSLocalizedString("Blank Question", comment: "")
        presentationMode = PresentationMode.presentModally(controllerProvider: ControllerProvider.storyBoard(storyboardId: "QuestionEditor", storyboardName: "Main", bundle: nil), onDismiss: {
            _ in
        })
        displayValueFor = {
            $0?.questionText ?? NSLocalizedString("Tap to edit", comment: "")
        }
    }
    
    required convenience init(tag: String?) {
        self.init(tag: tag)
    }
}
