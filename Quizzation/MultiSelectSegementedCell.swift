import Eureka
import MultiSelectSegmentedControl


public class MultiSelectSegmentedCell: Cell<NSMutableArray>, CellType, MultiSelectSegmentedControlDelegate {
    public typealias Value = NSMutableArray
    @IBOutlet var segmentedControl: MultiSelectSegmentedControl!
    
    public override func setup() {
        super.setup()
        segmentedControl.delegate = self
    }
    
    public override func update() {
        super.update()
        let value = [Any](row.value ?? NSMutableArray()).map { $0 as! String }
        let indexes = NSMutableIndexSet()
        if value.contains("A") {
            indexes.add(0)
        }
        if value.contains("B") {
            indexes.add(1)
        }
        if value.contains("C") {
            indexes.add(2)
        }
        if value.contains("D") {
            indexes.add(3)
        }
        segmentedControl.selectedSegmentIndexes = indexes
    }
    
    public func multiSelect(_ multiSelecSegmendedControl: MultiSelectSegmentedControl!, didChangeValue value: Bool, at index: UInt) {
        let arr = NSMutableArray(array: multiSelecSegmendedControl.selectedSegmentTitles)
        row.value = arr.count == 0 ? nil : arr
        row.updateCell()
    }
}

public final class MultiSelectSegmentedRow: Row<MultiSelectSegmentedCell>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<MultiSelectSegmentedCell>(nibName: "MultiSelectSegmentedCell")
    }
}
