//: [Previous](@previous)

import Foundation
import Combine

// Transform - Map
let numPubilisher = PassthroughSubject<Int, Never>()
let subscription1 = numPubilisher
    .map { $0 * 2 }
    .sink { value in
        print("Transformed Value: \(value)")
    }
numPubilisher.send(10)
numPubilisher.send(20)
numPubilisher.send(30)
subscription1.cancel()
//Transformed Value: 20
//Transformed Value: 40
//Transformed Value: 60
// Filter
let stringPublisher = PassthroughSubject<String, Never>()
let subscription2 = stringPublisher
    .filter { $0.contains("a") }
    .sink { value in
        print("Filtered Value: \(value)")
    }
stringPublisher.send("abc")
stringPublisher.send("Jack")
stringPublisher.send("Joon")
stringPublisher.send("Jenny")
stringPublisher.send("Jason")
subscription2.cancel()
//Filtered Value: abc
//Filtered Value: Jack
//Filtered Value: Jason

//: [Next](@next)
