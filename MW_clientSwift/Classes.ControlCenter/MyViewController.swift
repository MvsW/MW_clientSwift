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
    
    var views:[UIView] = []
    var actualViewController: UIViewController = UIViewController()
    var battle = false
    
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
            // println("output is")
            println("Server say: \(output)")
            var text = "Server say:  \(output) \n" //farem alguna cosa amb la variable?? es possible
            
        } else {
            // Handle error -> falta implementar...
            output = NO_SERVER
            println("ERROR => " + output.description)
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
    
    
    func startLoading(uiView:UIView, text:String, size2:CGFloat, viewController: UIViewController, areInBattle:Bool)->[UIView] {
        self.actualViewController = viewController
        self.battle = areInBattle
        var container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(red: 75, green: 75, blue: 75, alpha: 0.5)
        
        var loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 200, 150)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        var views:[UIView] = [loadingView,container]
        self.views = views
        
        var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 1.7);
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = text
        label.font = UIFont(name: "Helvetica", size: size2)
        
        var button = UIButton(frame: CGRectMake(0, 5, 100, 21))
        button.setBackgroundImage(UIImage(named: "menu_button_focus.jpg")!, forState: UIControlState.Normal)
        button.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 1.27)
        button.titleLabel?.font = UIFont.systemFontOfSize(12)
        button.setTitle("Cancel", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 2.5);
        actInd.color = UIColor.redColor()
        
        loadingView.addSubview(actInd)
        loadingView.addSubview(label)
        loadingView.addSubview(button)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
        
        return views
    }
    
    func stopLoading(views:[UIView]){
        views[0].removeFromSuperview()
        views[1].removeFromSuperview()
    }
    
    func buttonAction()
    {
        
        stopLoading(views)
        
        if(battle){
            application.myController.sendMessage(CANCEL)
            
            var succ = true
            
            while(succ){
                var a = application.myController.readMessage()
                println("!!! " + (a as String) + " !!!")
                if(a == SUCCES){
                    succ = false
                }
            }
            
            actualViewController.performSegueWithIdentifier("goto_menu", sender: self)
          
        }
    }
}
