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
        if let rowValue = row.value {
            let values = rowValue.map { $0 as! Int }
            multiSlider.value = values.map { CGFloat($0) }
            var textViewText = "A*: \(Int(values[4]))%\n"
            textViewText += "A: \(Int(values[3]))%\n"
            textViewText += "B: \(Int(values[2]))%\n"
            textViewText += "C: \(Int(values[1]))%\n"
            textViewText += "D: \(Int(values[0]))%"
            textView.text = textViewText
        }
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
