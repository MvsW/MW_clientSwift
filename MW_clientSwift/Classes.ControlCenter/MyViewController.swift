//
//  MyViewController.swift
//  MW_clientSwiftDesign
//
//  Created by Black Castle on 15/2/15.
//  Copyright (c) 2015 MW. All rights reserved.
//
// ViewController madreee!!!

// THIS CLASS IS UNDER DEVELOPMENT AND TESTING
import UIKit
import Foundation
import CFNetwork
import CoreLocation

//Els viewController tenen el tractament dels strems i de la localitzacio (No poden ser d'una altre classe que no sigui ViewController o Scenes)
class MyViewController: UIViewController, NSStreamDelegate , CLLocationManagerDelegate {
    //No sabem com es tramitara la conexio....
    
    //STREAMS
    var inputStream: NSInputStream!
    var outputStream: NSOutputStream!
    //LOCATION
    var manager:CLLocationManager!
    //BUFFERS
    var readStream:  Unmanaged<CFReadStream>?
    var writeStream: Unmanaged<CFWriteStream>?
    //CONTROL MESSAGES
    var messagesToBeSent:[String] = []
    var lastSentMessageID = 0
    var lastReceivedMessageID = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startClient()
        //per cada controller??
        // Do any additional setup after loading the view.
    }
    
    //METHODS 
    
    //start client
    func startClient(){
        setUpGsp()
        connect()
    }
    // gps (Experimental)
    func setUpGsp(){
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    //Send message
    func sendMessage(text: String?){
        //segurament aixo tirara cap a tenir uns valors fixes i no tindrem null, pero esta tractat per si de cas
        var message:String? = text
        var data:NSData?
        var thisMessage:String!
        
        if message == nil{
            message = ""
            data = message?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        }
        else{
            thisMessage = message!
            data = message!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        }
        
        //wait() //caldra sincronitzar amb el servidor??
        println("Sent the following")
        
        let bytesWritten = outputStream.write(UnsafePointer(data!.bytes), maxLength: data!.length)
        
        lastSentMessageID++
        
        //println(thisMessage)
        println("Bytes send to server: ")
        println(bytesWritten) //int count (-1) si es -1 no es pot enviar al servidor
        checkDisconnect(bytesWritten) //bucle infinit? "NOOOO!! PUEDES!! PASAAAAAR!!" by Gandalf el Gris
    }
    
    func readMessage() -> NSString{
        var output:NSString!
        let bufferSize = 1024
        var buffer = Array<UInt8>(count: bufferSize, repeatedValue: 0)
        var bytesRead: Int = inputStream.read(&buffer, maxLength: bufferSize)
        
        //println(bytesRead)
        if bytesRead >= 0 {
            lastReceivedMessageID++
            output = NSString(bytes: &buffer, length: bytesRead, encoding: NSUTF8StringEncoding)
            //println("output is")
            println("Server say: \(output)")
            var text = "Server say:  \(output) \n" //farem alguna cosa amb la variable?? es possible
            
        } else {
            println("error")
            // Handle error -> falta implementar...
        }
        return output
        
    }
    
    //Conectem a cada viewController? es pot mantenir?
    func connect(){
        
        //Create socket to host
        CFStreamCreatePairWithSocketToHost(nil, serverAddress, serverPort, &readStream, &writeStream)
        
        //Get the value of a managed refence
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        //Delegate view controller the handling of events
        inputStream!.delegate = self
        outputStream!.delegate = self
        
        //execute a loop to listen and write
        inputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        outputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        //Open streams and start the party
        inputStream.open()
        outputStream.open()
        
    }
    
    //al perdre la senyal entrem en un bucle infinit, fem un checkeo per acabar amb ell si pasa
    func checkDisconnect(val :Int){
        if val == -1{
            self.outputStream.close()
            self.outputStream.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            self.inputStream.close()
            self.inputStream.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            //Tenim que fer alguna cosa al desconectar?
        }
        
    }
    
    //HANDLE STREAMS
    func stream(stream: NSStream, handleEvent eventCode: NSStreamEvent) {
        var s = "stream event: "
        switch(eventCode) {
        case NSStreamEvent.HasBytesAvailable: //Handling a bytes-available event
            println(s + "Has bytes available")
            if let inputStream = stream as? NSInputStream {
                if inputStream.hasBytesAvailable {
                    
                                    }
                
            }
            break
        case NSStreamEvent.HasSpaceAvailable: //Accept write
            println(s + "Has space available")
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
            break
        case NSStreamEvent.EndEncountered: //Closing and releasing the NSInputStream objec
            println(s+"EndEncountered \(stream)")
        
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
    
    //No quiero tener que usar este metodo
    func wait() {
        while true {
            // println("waiting \(lastSentMessageID)  = \(lastReceivedMessageID)")
            if lastSentMessageID == lastReceivedMessageID && lastReceivedMessageID > 0  {
//                println("wait F*")
                break
            } 
            
            
            NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 0.1));
            NSThread.sleepForTimeInterval(0.1)
        }
    }
    
    //Handle location (Experimental)
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        println("locations = \(locations)")
        //tv_xivato.text = "success locations = \(locations)"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
