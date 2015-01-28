//
//  ViewController.swift
//  MW_clientSwift
//
//  Created by Black Castle on 16/1/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit
import Foundation
import CFNetwork
import CoreLocation



class ViewController: UIViewController, NSStreamDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var btn_send: UIButton!
    @IBOutlet weak var tv_xivato: UILabel!
    @IBOutlet weak var tv_log: UITextView!
    @IBOutlet weak var btn_connect: UIButton!
    @IBOutlet weak var et_ip: UITextField!
    @IBOutlet weak var et_message: UITextField!
    
    var serverAddress: CFString = "192.168.1.13"
    let serverPort: UInt32 = 4444
    var inputStream: NSInputStream!
    var outputStream: NSOutputStream!
    
    var manager:CLLocationManager!
    
    var readStream:  Unmanaged<CFReadStream>?
    var writeStream: Unmanaged<CFWriteStream>?
    
    //var inp : NSInputStream?
   // var out : NSOutputStream?
    
    var messagesToBeSent:[String] = []
    var lastSentMessageID = 0
    var lastReceivedMessageID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_send.enabled = false
        setUpGsp()

    }

    @IBAction func btnConnectClick(sender: AnyObject){
        serverAddress = et_ip.text
        connect()
        btn_send.enabled = true
        btn_connect.enabled = false
        
        
    }
    
    @IBAction func btnSendClick(sender: AnyObject){
        tv_log.text! += "-->"+et_message.text+"\n"
        sendMessage(et_message.text)
        et_message.text = ""
        
        
    }
    func setUpGsp(){
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }

    func connect(){
        
        CFStreamCreatePairWithSocketToHost(nil, serverAddress, serverPort, &readStream, &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        inputStream!.delegate = self
        outputStream!.delegate = self
        
        
        inputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        outputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        inputStream.open()
        outputStream.open()
        
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
                        var output: NSString! = NSString(bytes: &buffer, length: bytesRead, encoding: NSUTF8StringEncoding)
                        //println("output is")
                        println("Server say: \(output)")
                        var text = "Server say:  \(output) \n"
                        tv_log.text! += text
                        
                        break
                    } else {
                        println("error")
                        // Handle error
                    }
                }
                
            }
                break
        case NSStreamEvent.HasSpaceAvailable: //Accept write
            println(s+"Has Space Available")
            if let outputStream = stream as? NSOutputStream{
                if outputStream.hasSpaceAvailable { //stream ready for input
                    //println("true hasSpaceAvailable")
                    //sendMessage(et_message.text, outpuStream: stream)
                    
                    break
                }
            }
            break
        case NSStreamEvent.OpenCompleted:
            println("Stream opened")
            tv_log.text! += "Stream opened \n"
            break
        case NSStreamEvent.EndEncountered: //Closing and releasing the NSInputStream objec
            println(s+"EndEncountered \(stream)")
            
            btn_send.enabled = true
            btn_connect.enabled = false
            stream.close()
            stream.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            break
        case NSStreamEvent.ErrorOccurred: // Error reading NSInputStream
            println(s+"Error reading stream!")
            stream.close()
            stream.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            break
            
        default:
            println(s+"default --> jajaja cazame!!")
            break
        }
        
    }
    
    func sendMessage(text: String?){
        var message:String? = text
        var data:NSData?
        var thisMessage:String!
        
        if message == nil{
            message = ""
            data = message?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)?
        }
        else{
            thisMessage = message!
            data = message!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        }
        
        //wait()
        println("Sent the following")
        
        let bytesWritten = outputStream.write(UnsafePointer(data!.bytes), maxLength: data!.length)
        
        lastSentMessageID++
        
        //println(thisMessage)
        println("Message sent to server and response is")
        println(bytesWritten) //int count (-1)
        checkDisconnect(bytesWritten)
    }
    func checkDisconnect(val :Int){
        if val == -1{
            self.outputStream.close()
            self.outputStream.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            self.inputStream.close()
            self.inputStream.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            btn_send.enabled = false
            btn_connect.enabled = true
        }
        
    }
    
    func wait() {
        while true {
           // println("waiting \(lastSentMessageID)  = \(lastReceivedMessageID)")
            if lastSentMessageID == lastReceivedMessageID && lastReceivedMessageID > 0  {
                println("here")
                break
           }
            
            NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 0.1));
            NSThread.sleepForTimeInterval(0.1)
        }
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:AnyObject) {
        println("locations = \(locations)")
        tv_xivato.text = "success ocations = \(locations)"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

