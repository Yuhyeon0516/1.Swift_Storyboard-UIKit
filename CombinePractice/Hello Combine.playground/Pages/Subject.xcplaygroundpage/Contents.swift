import Foundation
import Combine

// PassthroughSubject
let relay = PassthroughSubject<String, Never>()
let subscription1 = relay.sink { value in
    print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World!")
//subscription1 received value: Hello
//subscription1 received value: World!

// CurrentValueSubject

let variable = CurrentValueSubject<String, Never>("") // CurrentValueSubject는 초기값이 필요함
let subscription2 = variable.sink { value in
    print("subscription2 received value: \(value)")
}

variable.send("More text")
//subscription2 received value:
//subscription2 received value: More text

variable.value // "More text"

let publisher = ["Here", "we", "go"].publisher
publisher.subscribe(relay) // publisher -> relay 전달하면서 subscription1이 호출됨
//subscription1 received value: Here
//subscription1 received value: we
//subscription1 received value: go
