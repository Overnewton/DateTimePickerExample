//
//  ViewController.swift
//  DateTimePicker
//
//  Created by Michael Robertson on 24/7/2026.
//

import UIKit

class ViewController: UIViewController {

    
    //Outlets
    
    //A UI date picker that allows the user to pick a date and time and can store the input as a `Date` type
    @IBOutlet weak var dteAppInput: UIDatePicker!
    @IBOutlet weak var lblShowDate: UILabel!
    
    /**
  Function: btnShowDate
     - Shows the date that is selected in the date picker `dteAppInput`
     - Saves the date to a new ClassExample object
     - Formats the date for a debug print statment in several different formats
     
     SOURCE: https://claude.ai/share/da4d58bc-5f84-47c4-bf5b-6c81b1982780
     SOURCE:  http://auth0.com/blog/introduction-date-time-programming-swift-2/
     
     WHY: Needed to find an example and a few different solutions to being able to get a selected Date object to then calculate two dates with and be able to format as a String - (Dates are annoying and tricky; especially with Swift as there's about 6 different Classes that can be used!!!!)
     
     HOW/MODIFIED: Took examples and created class methods to return a string from the date and created a couple of examples that both manually calculated usign modulus and created a timeDate formatter
     
     
     */
    
    
    @IBAction func btnShowDate(_ sender: Any) {
        
        //Save the date from date picker as a Date type object
        let selectedDate : Date = dteAppInput.date
        
        
        //Create a newClassObect (original name I know...) that stores the selectedDate and a test string (again original...)
        let newClassObject: ClassExample = ClassExample(
            date: selectedDate,
            name: "Test"
        )
        
        /*Shows the method of showDateString to the label
        e.g:
         30 July 2026
         7:45 pm
        */
        
        lblShowDate.text = newClassObject.showDateString()
        
        //Saves a new Date as the current dateTime right now
        let currentDateTime: Date = Date()
        
        //Stores a number that counts the amount of time between 2 dates as seconds; converts it to an Int for easier calculations
        //This can be used to calculate the amount of days/hours etc later on
        let timeDifference = selectedDate.timeIntervalSince(currentDateTime)
        
        let timeDiffInt = Int(timeDifference)
        
        //below are a few methods to be able to show the calculated time between 2 dates
        
        //OPTION 1: Manually calculate the difference in time by dividing the amount of seconds by 86400 for days, then modulus 86400 and divide 3600 for hours, and modulus 3600 and divide by 60 for minutes
        
        let daysAmount = timeDiffInt / 86400
        let hoursAmount = (timeDiffInt % 86400) / 3600
        let minutesAmount = (timeDiffInt % 3600) / 60
        
        
        
       print("Debug for manual time conversion")
        print(
            "The difference in time is:\n \(daysAmount) days\n \(hoursAmount) hours\n \(minutesAmount) minutes"
        )
        

        
        
        //OPTION 2: Create a formatted amount of days/time to show using the difference in time
        
        //We first create a DateComponentsFormatter constant to note what we want to convert and show
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .abbreviated   // "2 hr, 15 min"
        // other styles: .full "2 hours, 15 minutes", .short ("2h 15m"), .positional ("2:15:00")

        let readableDuration = formatter.string(from: timeDifference)
        
        print("Debug for formatter object time conversion")
        print("The difference in time is:\n \(readableDuration!)")

        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}



/**
 -- Example class that is made to hold 2 properties of `date` and `name --
 */

class ClassExample {
    
  
    //This is a date that is of a Date type
    //Dates are numerical types that can do things like compare between dates, add time, minus time etc
    var date: Date
    var name: String
    
    //Initialiser to create an object
    init(date: Date, name: String) {
        self.date = date
        self.name = name
    }
    
    
    ///Function: showDateString
    func showDateString() -> String {
        
        //This is a DateFormatter object that can be used to show only the date in the .medium style
        //.medium is like 30 Jul 2026
        let dateOnlyFormat = DateFormatter()
        dateOnlyFormat.dateStyle = .medium
        
        //This is a DateFormatter object that can be used to show only the time in the .medium style
        //.short is like 7:23 pm
        let timeOnlyFormat = DateFormatter()
        timeOnlyFormat.timeStyle = .short
        
        //This returns a string from the date property given so that it can show the date and the time.
        return (
            "\(dateOnlyFormat.string(from: date)) \n \(timeOnlyFormat.string(from: date))"
        )
        
        
    }
    
}

