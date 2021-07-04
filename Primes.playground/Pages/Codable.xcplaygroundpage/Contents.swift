//: [Previous](@previous)

import UIKit

// We got Codable for free here simply by declaring it.
// You get it for all JSON core types: numbers, strings, booleans, arrays, dictionaries, optionals
struct Robot: Codable {
    let modelNumber: Int
    let name: String
}

// This is not a string
// This is not a number
// It's a complex type with all kinds of subtype information
let robby = Robot(modelNumber: 1, name: "Robby")
let c3po = Robot(modelNumber: 3, name: "C3PO")

// JSON is way to represent information using strings
// Serialization -> convert from a complex thing into a simple thing (in this case a string)


// Throw means that a call can produce an error so you need to
// annotate your call with some kind of wording that lets Swift know
// that you have opted into the error system, that is `try`
// There are three kinds of try: `try`, `try?`, and `try!`
//
// try! = try or die, if it fails, fatal error, only call on stuff you know will never fail, many devs avoid entirely
// try? = try or nil, if it fails, you get nil, otherwise you get optional data, you entirely lose error handling and discarding any error information. Errors are normally passed to you with good reason, do not discard them lightly unless you have some reasonable motivation to do so

var outerData: Data = Data()

// The opposite of throwing is...catching
// You do this either by annotating a function as "throwing" or "rethrowing"
// *or* you use what's called a do-catch construct <-- we'll use this one
do {
    // Lets you use `try` with immediate catching and resolution of errors
    // Always think about do-catch clause scoping because often, you'll need to use
    // whatever data you construct inside the do-clause outside of it
    let data = try JSONEncoder().encode(robby)
    
    // I am converting the string data so you can see with your eyes and
    // understand what it looks like
    guard let string = String(data: data, encoding: .utf8)
        else { fatalError("Unconstructable JSON String data") }
    outerData = data
    
    // The order of fields is not guaranteed nor does it have any meaning whatsoever
    // So long as you have all your information you can move between instances and
    // their codable JSON representation and back
    print(string)
} catch {
    // Where you handle errors
    NSLog("Error: \(error)")
}

outerData // I am about to convert this data back to an instance

do {
    let newRobot = try JSONDecoder().decode(Robot.self, from: outerData)
    print(newRobot.name, newRobot.modelNumber)
} catch {
    NSLog("Error: \(error)")
}

//: [Next](@next)
