
import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

  @IBOutlet var timeCount: WKInterfaceLabel!
  @IBOutlet var weightLabel: WKInterfaceLabel!
  @IBOutlet var caloriesBurntLabel: WKInterfaceLabel!
  @IBOutlet var runningTypePicker: WKInterfacePicker!
  
  var count = 0
  var weight = 0
  var timer = NSTimer()
  var runningSpeed = 0
  
  var runningList: [(String, String, Int)] = [
    ("Light", "5 MPH", 64),
    ("Moderate", "6 MPH", 79),
    ("Fast", "10 MPH", 100),
    ("Very Fast", "12 MPH", 130)
  ]
  
  override func willActivate() {
    super.willActivate()
    
    let pickerItems: [WKPickerItem] = runningList.map {
      let pickerItem = WKPickerItem()
      pickerItem.title = $0.0
      pickerItem.caption = $0.1
      
      return pickerItem
    }
    runningTypePicker.setItems(pickerItems)
  }
  
  func incrementCount() {
    count += 1
    timeCount.setText("\(count) sec")
    
    let caloriesBurnt = count * weight * runningSpeed / 60 / 1000
    caloriesBurntLabel.setText("\(caloriesBurnt) cal")
    
  }
  
  @IBAction func runningTypepickerAction(value: Int) {
    runningSpeed = runningList[value].2
  }
  
  @IBAction func weightSliderAction(value: Int) {
    weight = value
    weightLabel.setText("\(weight)")
  }

  @IBAction func startCounter() {
    timer.invalidate()
    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(incrementCount), userInfo: nil, repeats: true)
    
  }
  
  @IBAction func stopCounter() {
    timer.invalidate()
  }
  
  @IBAction func ResetCounter() {
    timer.invalidate()
    count = 0
    timeCount.setText("Time")
    caloriesBurntLabel.setText("Calories")
    
  }

}
