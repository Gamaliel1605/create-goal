//
//  CreateGoalController.swift
//  fix-mogo
//
//  Created by Carlos Gamaliel Manurung on 10/04/21.
//

import UIKit


class CreateGoalController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    //viewheader
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var buttonIcon: UIButton!
    @IBOutlet weak var labelIcon: UILabel!
    
    //input goal
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalInput: UITextField!
    
    //input budget
    @IBOutlet weak var budgetView: UIView!
    @IBOutlet weak var budgetLock: UIButton!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var budgetInput: UITextField!
    
    //input date
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLock: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateInput: UITextField!
    
    //amount save
    @IBOutlet weak var monthSaving: UIView!
    @IBOutlet weak var monthLock: UIButton!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var monthInput: UITextField!
    
    //remind freq
    @IBOutlet var freqView: UIView!
    @IBOutlet var freqLabel: UILabel!
    @IBOutlet var freqInput: UITextField!
    
    //remind date
    @IBOutlet var savingDateView: UIView!
    @IBOutlet var savingDateLabel: UILabel!
    @IBOutlet var savingDateInput: UITextField!
    
    //remind time
    @IBOutlet var timeInput: UITextField!
    @IBOutlet var timeView: UIView!
    @IBOutlet var timeLabel: UILabel!
    
    var arrayFrequency = ["Monthly", "Weekly"]
    var arrayMonth = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
    var weekArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var datePicker = UIDatePicker()
    var timePicker = UIDatePicker()
    var pickerView = UIPickerView()
    var temp = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call icon
        borderView()
        createDatePicker()
        setupView()
        createTimePicker()
        pickerView.delegate = self
        pickerView.dataSource = self
        freqInput.inputView = pickerView
    }
    
    func setupView(){
        budgetInput.placeholder = "IDR 10.000.000"
        dateInput.placeholder = "1 January 2021"
        monthInput.placeholder = "IDR 1.000.000"
        timeInput.placeholder = "12:00"
        freqInput.placeholder = "Monthly"
        savingDateInput.placeholder = "2"
    }
    
    func borderView(){
        
        nameView.layer.borderColor = UIColor.lightGray.cgColor
        nameView.layer.borderWidth = 0.5
        
        budgetView.layer.borderColor = UIColor.lightGray.cgColor
        budgetView.layer.borderWidth = 0.5
        
        dateView.layer.borderColor = UIColor.lightGray.cgColor
        dateView.layer.borderWidth = 0.5
        
        monthSaving.layer.borderColor = UIColor.lightGray.cgColor
        monthSaving.layer.borderWidth = 0.5
        
        freqView.layer.borderColor = UIColor.lightGray.cgColor
        freqView.layer.borderWidth = 0.5
        
        savingDateView.layer.borderColor = UIColor.lightGray.cgColor
        savingDateView.layer.borderWidth = 0.5
        
        timeView.layer.borderColor = UIColor.lightGray.cgColor
        timeView.layer.borderWidth = 0.5
    }
    
    //func icon
    @IBAction func toIconCollection(_ sender: UIButton) {
//        let detailIcon = IconController()
//        self.navigationController?.pushViewController(detailIcon, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == goalInput{
            goalInput.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
    @IBAction func budgetLock(_ sender: UIButton) {
        if temp == 0 {
            budgetLock.setImage(UIImage(named: "Lock"), for: .normal)
            temp = 1
        } else if temp == 1 {
            budgetLock.setImage(UIImage(named: "Unlock"), for: .normal)
            temp = 0
        }
    }
    
    @IBAction func dateLock(_ sender: Any) {
        if temp == 0 {
            dateLock.setImage(UIImage(named: "Lock"), for: .normal)
            temp = 1
        } else if temp == 1 {
            dateLock.setImage(UIImage(named: "Unlock"), for: .normal)
            temp = 0
        }
    }
    
    @IBAction func monthLock(_ sender: Any) {
        if temp == 0 {
            monthLock.setImage(UIImage(named: "Lock"), for: .normal)
            temp = 1
        } else if temp == 1 {
            monthLock.setImage(UIImage(named: "Unlock"), for: .normal)
            temp = 0
        }
    }
    
    func createDatePicker(){
        self.datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.targetDate), for: .allEvents)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        self.dateInput.inputView = datePicker
        let toolBar:UIToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        let spaceButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.tapDone))
        toolBar.setItems([spaceButton, doneButton], animated: true)
        self.dateInput.inputAccessoryView = toolBar
    }
    
    @objc func targetDate(){
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        self.dateInput.text = dateFormat.string(from: datePicker.date)
    }
    
    @objc func tapDone(){
        dateInput.resignFirstResponder()
    }
    
    func createTimePicker(){
        let time = Date()
        let formatter = DateFormatter()
        
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        }
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        
        timeInput.text = formatter.string(from: time)
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(targetTime), for: UIControl.Event.valueChanged)
        self.timeInput.inputView = timePicker
        let toolBar:UIToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        let spaceButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.tapDoneTime))
        toolBar.setItems([spaceButton, doneButton], animated: true)
        self.timeInput.inputAccessoryView = toolBar
        timeInput.inputView = timePicker
    }
    
    @objc func targetTime(sender: UIDatePicker){
        let formatter  = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        timeInput.text = formatter.string(from: sender.date)
    }
    
    @objc func tapDoneTime(){
        timeInput.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayFrequency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayFrequency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        freqInput.text = arrayFrequency[row]
        freqInput.resignFirstResponder()
    }
    
}
