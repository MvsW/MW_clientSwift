// Playground - noun: a place where people can play

import Cocoa

// create some data to read
var data: NSData = "Hello Regor".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:
true)!
data.length

// create a stream that reads the data above
let stream: NSInputStream = NSInputStream(data: data)

// begin reading
stream.open()
var buffer = [UInt8](count: 8, repeatedValue: 0)
while stream.hasBytesAvailable {
    let result: Int = stream.read(&buffer, maxLength: buffer.count)
    result // the number of bytes read is here
    buffer // the data read is in here
}


