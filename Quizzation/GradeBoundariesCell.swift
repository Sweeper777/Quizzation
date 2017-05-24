import Eureka
import MultiSlider

public class GradeBoundariesCell: Cell<NSMutableArray>, CellType {
    public typealias Value = NSMutableArray
    @IBOutlet var multiSlider: MultiSlider!
    @IBOutlet var textView: UITextView!
    
    public override func setup() {
        super.setup()
        
    }
    
    public override func update() {
        super.update()
    }
    
    @IBAction func valueChange(_ sender: MultiSlider) {
    }
}
