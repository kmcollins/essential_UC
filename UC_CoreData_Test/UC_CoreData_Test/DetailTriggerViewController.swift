//
//  DetailTriggerViewController.swift
//  UC_CoreData_Test
//
//  Created by Katie Collins on 1/31/17.
//  Copyright © 2017 CollinsInnovation. All rights reserved.
//

import Foundation
import UIKit

class DetailTriggerViewContoller: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var entries: [Entry] = []
    
    let pickerData = ["PUCAI Score", "Number of Stools", "Stool Consistency", "Nocturnal", "Rectal Bleeding", "Activity Level", "Abdominal Pain"]
    
    var triggerName: String! {
        didSet {
            navigationItem.title = triggerName
        }
    }
    
    @IBOutlet var graph: GraphView!
    @IBOutlet var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let unfilteredEntries = try context.fetch(Entry.fetchRequest()) as! [Entry]
            self.entries = filterEntries(unfilteredEntries)
        }
        catch {
            print("ERROR")
        }
        
        picker.dataSource = self
        picker.delegate = self
        
        //setUpGraphWithData(data: pucaiArray())
    }
    
    func filterEntries(_ data: [Entry]) -> [Entry] {
        var filteredEntries: [Entry] = []
        for entry in data {
            if let triggers = entry.triggerArrayAsString?.components(separatedBy: " ") {
                if triggers.contains(triggerName) { filteredEntries.append(entry) }
            }
        }
        return filteredEntries // these are the entries wherein the trigger occured
    }
    
    func pucaiArray() -> [Int]{
        var pucai: [Int] = []
        for e in entries {
            pucai.append(Int(e.pucaiScore))
        }
        return pucai
    }
    
    func nocturnalArray() -> [Int]{
        var nocturnal: [Int] = []
        for e in entries {
            nocturnal.append(Int(e.nocturnal))
        }
        return nocturnal
    }
    
    func bleedingArray() -> [Int]{
        var rectalBleeding: [Int] = []
        for e in entries {
            rectalBleeding.append(Int(e.rectalBleeding))
        }
        return rectalBleeding
    }
    
    func activityLevelArray() -> [Int]{
        var activityLevel: [Int] = []
        for e in entries {
            activityLevel.append(Int(e.activityLevel))
        }
        return activityLevel
    }
    
    func abdPainArray() -> [Int]{
        var abdominalPain: [Int] = []
        for e in entries {
            abdominalPain.append(Int(e.abdominalPain))
        }
        return abdominalPain
    }
    
    func numStoolsArray() -> [Int]{
        var numStools: [Int] = []
        for e in entries {
            numStools.append(Int(e.numStools))
        }
        return numStools
    }
    
    func consistencyArray() -> [Int]{
        var stoolConsistency: [Int] = []
        for e in entries {
            stoolConsistency.append(Int(e.stoolConsistency))
        }
        return stoolConsistency
    }
    
    func setUpGraphWithData(data: [Int]) {
        graph.vals = data
        graph.number = entries.count
        graph.setNeedsDisplay()
    }
    
    // Returns the number of 'columns' to display...UIPickerView!
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // Returns the # of rows in each component.. ..UIPickerView!
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        let identifier = pickerData[row]
        
        switch (identifier) {
        case "PUCAI Score":
            setUpGraphWithData(data: pucaiArray())
        case "Stool Consistency":
            setUpGraphWithData(data: consistencyArray())
        case "Activity Level":
            setUpGraphWithData(data: pucaiArray())
        case "Number of Stools":
            setUpGraphWithData(data: numStoolsArray())
        case "Abdominal Pain":
            setUpGraphWithData(data: abdPainArray())
        case "Rectal Bleeding":
            setUpGraphWithData(data: bleedingArray())
        case "Nocturnal":
            setUpGraphWithData(data: nocturnalArray())
        default:
            break
        }
    }

}
