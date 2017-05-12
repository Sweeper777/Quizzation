import Eureka

public class SingleSelectSegmentedCell: Cell<Character>, CellType {
    public typealias Value = Character
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    public override func setup() {
        super.setup()
    }
    
    public override func update() {
        super.update()
        if let value = row.value {
            switch value {
            case "A":
                segmentedControl.selectedSegmentIndex = 0
            case "B":
                segmentedControl.selectedSegmentIndex = 1
            case "C":
                segmentedControl.selectedSegmentIndex = 2
            case "D":
                segmentedControl.selectedSegmentIndex = 3
            default:
                segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
            }
        } else {
            segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        }
    }
    
    @IBAction func valueChange() {
        row.value = ["A", "B", "C", "D"][segmentedControl.selectedSegmentIndex]
    }
}

public final class SingleSelectSegmentedRow: Row<SingleSelectSegmentedCell>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<SingleSelectSegmentedCell>(nibName: "SingleSelectSegmentedCell")
    }
}
