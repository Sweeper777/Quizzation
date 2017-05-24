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
        row.value = NSMutableArray(array: sender.value.map { Int($0) })
        var textViewText = "A*: \(Int(sender.value[4]))%\n"
        textViewText += "A: \(Int(sender.value[3]))%\n"
        textViewText += "B: \(Int(sender.value[2]))%\n"
        textViewText += "C: \(Int(sender.value[1]))%\n"
        textViewText += "D: \(Int(sender.value[0]))%"
        textView.text = textViewText
    }
    }
}
