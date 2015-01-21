//
//  ViewController.swift
//  MW_clientSwift
//
//  Created by Black Castle on 16/1/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit
import Foundation;
import Dispatch;
import CFNetwork;



class ViewController: UIViewController, NSStreamDelegate {

    let serverAddress: CFString = "172.16.253.55"
    let serverPort: UInt32 = 4444
    var inputStream: NSInputStream!
    var outputStream: NSOutputStream!
    
    var readStream:  Unmanaged<CFReadStream>?
    var writeStream: Unmanaged<CFWriteStream>?
    
    var messagesToBeSent:[String] = []
    var lastSentMessageID = 0
    var lastReceivedMessageID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MI PRIMER TEST CLIENT SWIFT TO JAVA SERVER
        connect()
        println("Connected to \(serverAddress)")
        
        
    }

    func connect(){
        //socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);  // IPv4
        //socket(PF_INET6, SOCK_STREAM, IPPROTO_TCP); // IPv6
        CFStreamCreatePairWithSocketToHost(nil, serverAddress, serverPort, &readStream, &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        inputStream!.delegate = self
        outputStream!.delegate = self
        
        outputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        inputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        outputStream.open()
        inputStream.open()
    }
    
    //Listening
    func stream(stream: NSStream, handleEvent eventCode: NSStreamEvent) {
        var s = "stream event:"
        switch(eventCode) {
        case NSStreamEvent.HasBytesAvailable: //Handling a bytes-available event
            println(s+"Has bytes available")
            
            if let inputStream = stream as? NSInputStream {
                if inputStream.hasBytesAvailable {
                    let bufferSize = 1024
                    var buffer = Array<UInt8>(count: bufferSize, repeatedValue: 0)
                    var bytesRead: Int = inputStream.read(&buffer, maxLength: bufferSize)
                    //println(bytesRead)
                    if bytesRead >= 0 {
                        lastReceivedMessageID++
                        var output: String? = NSString(bytes: &buffer, length: bytesRead, encoding: NSUTF8StringEncoding)?
                        //println("output is")
                        println(output)
                    } else {
                        println("error")
                        // Handle error
                    }
                }
            }
            /*
                var readByte :UInt8 = 0
                while inputStream.hasBytesAvailable {
                let result: Int = inputStream.read(&readByte, maxLength: 1)
                }
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
            
                break
        case NSStreamEvent.HasSpaceAvailable: //Accept write
            println(s+"PROTOTYPE PROTOCOL swift")
            var message:String? = "SHIT"
            
            if let outputStream = stream as? NSOutputStream{
                if outputStream.hasSpaceAvailable { //stream ready for input
                    println("true hasSpaceAvailable")
                    var data:NSData
                    var thisMessage:String
                    thisMessage = message!
                    data = message!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
                    println("Sent the following")
                    //wait()
                    let bytesWritten = outputStream.write(UnsafePointer(data.bytes), maxLength: data.length)
                    lastSentMessageID++
                    //println(thisMessage)
                    println("Message sent to server and response is")
                    //println(bytesWritten) //int count
                }
                else{ //steam busy
                    println("no space available in stream")
                    if message != nil{
                        messagesToBeSent.append(message!)
                    }
                }
            }
            
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
            
            break
        case NSStreamEvent.OpenCompleted:
            println(s+"Stream opened")
            break
        case NSStreamEvent.EndEncountered: //Closing and releasing the NSInputStream objec
            println(s+"EndEncountered")
            
            //stream.close()
            //stream.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            //outputStream.close()
            //outputStream.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            break
        case NSStreamEvent.ErrorOccurred: // Error reading NSInputStream
            println(s+"Error reading stream!")
            stream.close()
            break;
        default:
            println(s+"default --> jajaja cazame!!")
            break
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

