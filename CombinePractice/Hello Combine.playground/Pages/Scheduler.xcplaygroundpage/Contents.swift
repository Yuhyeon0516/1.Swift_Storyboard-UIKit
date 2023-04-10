//: [Previous](@previous)

import Foundation
import Combine

let arrPublisher = [1, 2, 3].publisher
let queue = DispatchQueue(label: "custom")
let subscription = arrPublisher
    .subscribe(on: queue)
    .map{ value -> Int in
        print("transform: \(value), threed: \(Thread.current)")
        return value
    }
    .receive(on: DispatchQueue.main)
    .sink { value in
        print("Receive Value: \(value), thread: \(Thread.current)")
    }
//transform: 1, threed: <NSThread: 0x600003780500>{number = 5, name = (null)}
//transform: 2, threed: <NSThread: 0x600003780500>{number = 5, name = (null)}
//transform: 3, threed: <NSThread: 0x600003780500>{number = 5, name = (null)}
// Custom Thread에서 값을 주고 main Thread에서 값을 받아 출력함
//Receive Value: 1, thread: <_NSMainThread: 0x60000379c240>{number = 1, name = main}
//Receive Value: 2, thread: <_NSMainThread: 0x60000379c240>{number = 1, name = main}
//Receive Value: 3, thread: <_NSMainThread: 0x60000379c240>{number = 1, name = main}


//: [Next](@next)
