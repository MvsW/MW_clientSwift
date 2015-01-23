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
var buffer = [UInt8](count: 1024, repeatedValue: 0)
while stream.hasBytesAvailable {
    let result: Int = stream.read(&buffer, maxLength: buffer.count)
    result // the number of bytes read is here
    buffer // the data read is in here
}

/*
//OTHER read stream
var readByte :UInt8 = 0
while inputStream.hasBytesAvailable {
let result: Int = inputStream.read(&readByte, maxLength: 1)
}


READ STREAM OBJECTIVE-C
////////////

if(!_data) {
_data = [[NSMutableData data] retain];
}
uint8_t buf[1024];
unsigned int len = 0;
len = [(NSInputStream *)stream read:buf maxLength:1024];
if(len) {
[_data appendBytes:(const void *)buf length:len];
// bytesRead is an instance variable of type NSNumber.
[bytesRead setIntValue:[bytesRead intValue]+len];
} else {
println("no buffer!")
}
*/
//WRITE STREAM OBJECTIVE-C
/*
uint8_t *readBytes = (uint8_t *)[_data mutableBytes];
readBytes += byteIndex; // instance variable to move pointer
int data_len = [_data length];
unsigned int len = ((data_len - byteIndex >= 1024) ?
1024 : (data_len-byteIndex));
uint8_t buf[len];
(void)memcpy(buf, readBytes, len);
len = [stream write:(const uint8_t *)buf maxLength:len];
byteIndex += len;
*/



