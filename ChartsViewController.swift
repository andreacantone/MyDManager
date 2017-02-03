//
//  ChartViewController.swift
//  My Diabetic Manager
//
//  Created by Vincenzo De Rosa on 01/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//
import UIKit
import Charts

var disclaimerHasBeenDisplayed = false
struct Giorno{
    var nGiorno : Int = 0
    var values : [Double] = []
}

struct Settimana{
    var nSettimana : Int = 0
    var giorni = [Giorno](repeating: Giorno(), count: 7)
}

struct Mese{
    var nMese : Int = 0
    var settimane = [Settimana](repeating: Settimana(), count: 5)
}

struct Anno{
    var nAnno : Int = 0
    var mesi = [Mese](repeating: Mese(), count: 12)
}


func inizialize_year()->Anno{
    let data = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: data)
    let year:Int =  components.year!
    var ANNO = Anno()
    ANNO.nAnno = year
    for i in 0...11{
        ANNO.mesi[i].nMese = i + 1
        for j in 0...4{
            ANNO.mesi[i].settimane[j].nSettimana = j+1
            for k in 0...6{
                ANNO.mesi[i].settimane[j].giorni[k].nGiorno = k+1
                ANNO.mesi[i].settimane[j].giorni[k].values = []
            }
        }
    }
    return ANNO
}

class ChartViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var Salva: UIButton!
    @IBOutlet weak var valore: UITextField!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var viewForChart: LineChartView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    var support_day: [String] = []
    var support_week: [String] = []
    var support_month: [String] = []
    var period: [String] = []
    var current_year: Anno = Anno()
    
    @IBAction func addValue(_ sender: UIButton) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: NSDate() as Date)
        let data = returnDate()
        let mese_c = getMonth(data)!
        let sett_c = getWeekOfMonth(data)!
        let giorno_c = getDayOfWeek(data)!
        let letters = NSCharacterSet.letters
        let range = valore.text!.rangeOfCharacter(from: letters)
        if (valore.text != "" && range == nil){
            if (Double(valore.text!))! >= 0.00{
                current_year.mesi[mese_c-1].settimane[sett_c-1].giorni[giorno_c-1].values.append(Double(valore.text!)!)
                support_day.append(timeString)
                period = support_day
                let values = current_year.mesi[mese_c-1].settimane[sett_c-1].giorni[giorno_c-1].values
                setChart(dataEntryX: period, dataEntryY: values)
                UserDefaults.standard.set(String(average(nums: values)), forKey: "average")
                UserDefaults.standard.synchronize()
                textLabel.text = String(average(nums: values))
            }
        }
        else{
            let alertController = UIAlertController(title: "Attention!", message: "Insert a valid value!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        let data = returnDate()
        let mese_c = getMonth(data)!
        let sett_c = getWeekOfMonth(data)!
        let giorno_c = getDayOfWeek(data)!
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            let values = current_year.mesi[mese_c-1].settimane[sett_c-1].giorni[giorno_c-1].values
            if !period.isEmpty && values.isEmpty{
                setChart(dataEntryX: [""], dataEntryY: [0.00])
                textLabel.text = String(average(nums: []))
            }
            else{
                period = support_day
                setChart(dataEntryX: period, dataEntryY: values)
                textLabel.text = String(average(nums: values))
            }
            
        case 1:
            //init week
            var values: [Double] = []
            let week = current_year.mesi[mese_c-1].settimane[sett_c-1]
            for day in week.giorni{
                values.append(average(nums: day.values))
            }
            support_week = ["Lun", "Mar", "Mer", "Gio", "Ven", "Sab", "Dom"]
            period = support_week
            setChart(dataEntryX: period, dataEntryY: values)
            textLabel.text = String(average(nums: values))
            
        case 2:
            var values: [Double] = []
            var values_week: [Double] = []
            var values_month: [Double] = []
            for month in current_year.mesi{
                for week in month.settimane{
                    for day in week.giorni{
                        values.append(average(nums: day.values))
                    }
                    values_week.append(average(nums: values))
                    values.removeAll()
                }
                values_month.append(average(nums: values_week))
                values_week.removeAll()
            }
            support_month = ["Gen", "Feb", "Mar", "Apr", "Mag", "Giu", "Lug", "Ago", "Set", "Ott", "Nov", "Dic"]
            period = support_month
            setChart(dataEntryX: period, dataEntryY: values_month)
            textLabel.text = String(average(nums: values_month))
            
        default:
            break
        }
        
    }
    

    
    func average(nums: [Double]) -> Double {
        if nums.isEmpty{return 0.00}
        else{
            var total = 0.0
            for vote in nums{
                total += Double(vote)
            }
            let votesTotal = Double(nums.count)
            let average = total/votesTotal
            return average
        }
    }
    
    func returnDate()->(String){
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let year:Int =  components.year!
        let month:Int = components.month!
        let day:Int = components.day!
        return "\(year)-\(month)-\(day)"
    }
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay - 1
    }
    
    func getMonth(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let month = myCalendar.component(.month, from: todayDate)
        return month
    }
    
    func getWeekOfMonth(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekMonth = myCalendar.component(.weekOfMonth, from: todayDate)
        return weekMonth
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_year = inizialize_year()
        axisFormatDelegate = self
        valore.delegate = self
        todayLabel.text = returnDate()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Double]) {
        viewForChart.noDataText = "You need to provide data for the chart."
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<forX.count{
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(forY[i]) , data: forX as AnyObject?)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Glycemic Value")
        let chartData = LineChartData(dataSet: chartDataSet)
        viewForChart.data = chartData
        let xAxisValue = viewForChart.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        viewForChart.rightAxis.drawLabelsEnabled = false
        xAxisValue.labelPosition = .bottom
        viewForChart.pinchZoomEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if disclaimerHasBeenDisplayed == false {
            
            disclaimerHasBeenDisplayed = true
            
            let alertController = UIAlertController(title: "Welcome!", message: "Here You can check and annotate your glycemic values!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Let's start!", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}

extension ChartViewController: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return period[Int(value)]
    }
}
