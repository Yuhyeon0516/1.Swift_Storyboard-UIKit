//: [Previous](@previous)

import Foundation
import Combine

let subject1 = PassthroughSubject<String, Never>()

// The print() operator prints you all lifecycle events
let subscription1 = subject1.sink { value in
    print("Subscripvber received value: \(value)")
}

subject1.send("Hello")
subject1.send("Hello again!")
subject1.send("Hellor for the last time!")
subject1.send(completion: .finished)
subject1.send("Hello ?? :(") // 위에서 finish를 선언하면서 구독티켓(연결)이 끊어짐
//Subscripvber received value: Hello
//Subscripvber received value: Hello again!
//Subscripvber received value: Hellor for the last time!

let subject2 = PassthroughSubject<String, Never>()
let subscription2 = subject2.print().sink { value in // print로 연결 상태 및 debug용 data 확인에 많이 쓰임
    print("Subscripvber received value: \(value)")
}

subject2.send("Hello")
subject2.send("Hello again!")
subject2.send("Hellor for the last time!")
subject2.send(completion: .finished)
subject2.send("Hello ?? :(")
//receive subscription: (PassthroughSubject)
//request unlimited
//receive value: (Hello)
//Subscripvber received value: Hello
//receive value: (Hello again!)
//Subscripvber received value: Hello again!
//receive value: (Hellor for the last time!)
//Subscripvber received value: Hellor for the last time!
//receive finished

let subject3 = PassthroughSubject<String, Never>()
let subscription3 = subject3.print("[Debug]").sink { value in
    print("Subscripvber received value: \(value)")
}

subject3.send("Hello")
subject3.send("Hello again!")
subject3.send("Hellor for the last time!")
subscription3.cancel()
//[Debug]: receive subscription: (PassthroughSubject)
//[Debug]: request unlimited
//[Debug]: receive value: (Hello)
//Subscripvber received value: Hello
//[Debug]: receive value: (Hello again!)
//Subscripvber received value: Hello again!
//[Debug]: receive value: (Hellor for the last time!)
//Subscripvber received value: Hellor for the last time!
//[Debug]: receive cancel
//: [Next](@next)
