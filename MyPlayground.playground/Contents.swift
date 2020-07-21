import UIKit

let serialQueue = DispatchQueue(label: "swiftlee.serial.queue")
let concurrentQueue = DispatchQueue(label: "swiftlee.serial.cqueue", attributes: .concurrent)

serialQueue.async {
    print("Task 1 started")
    // Do some work..
    print("Task 1 workinkg")

    print("Task 1 finished")
}
serialQueue.async {
    print("Task 2 started")
    // Do some work..
    print("Task 2 finished")
}
/////////////////////////////////////////////////////////
concurrentQueue.async {
    print("Task 1 (C) started")
    // Do some work..
    print("Task 1 (C) workinkg")

    print("Task 1 (C) finished")
}
concurrentQueue.async {
    print("Task 2 (C) started")
    // Do some work..
    print("Task 2 (C) finished")
}


//Inferring QoS
let label = "swiftlee.serial.queue"
let queue = DispatchQueue(label: label,
                            qos: .userInitiated,
                            attributes: .concurrent)


