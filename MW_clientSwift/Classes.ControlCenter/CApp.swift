//
//  CApp.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import Foundation
import UIKit

public class CApp{
    var myController = MyViewController()
    
    func isValidEmail(testStr:String) -> Bool {
        println("validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        var result = emailTest.evaluateWithObject(testStr)
        
        return result
    }

    func isValidPassword(testStr:String) -> Bool{
        if(count(testStr) >= 6){
            for chr in testStr{
                var str = String(chr)
                if(str.uppercaseString == str){
                return true
                }
            }
        }
        return false
    }
    
    func validateUserName(text:String) ->Bool{
        for character in text {
            if(character == "@"){
                return false
            }
        }
        for chr in text{
            var str = String(chr)
            if str.lowercaseString == str{
                return true
            }
        }
        return false
    }
    
    // Check if the playername conditions has been respected
    func validatePlayerName(text: String) ->Bool{
        let maxValue = 12;
        
        for character in text {
            if (character == "@" || character == " " ){
                return false
            }
            if (character.hashValue >= maxValue){
                return false
            }
        }
        
        // Converting all to lower case for evading errors
        for chr in text {
            var str = String(chr)
            if str.lowercaseString == str {
                return true
            }
        }
        return false
    }
    
    // Check the connection
    let reachability = Reachability.reachabilityForInternetConnection()

    func checkConnection()->Bool {
        println("Rechability said: " + reachability.currentReachabilityString)
        
        if(reachability.isReachable()){
            if(reachability.isReachableViaWiFi()){
            println("Via WIFI")
            }
            if(reachability.isReachableViaWWAN()){
            println("Via WWAN")
            }
            return true
        }else{
            println("NO INTERNET")
            return false
        }
    }
    
    func imageResize (imageObj:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    func getData(str: String)->String{
        let fullNameArr = str.componentsSeparatedByString(" ")
        return fullNameArr[0]
    }
    
    func getErrorName(num: String)->String{
        println("Error num: " + num)
        switch(num){
        case ERROR:
            return "Error general"
        case NO_SERVER:
            return "Maybe server is in maintenance. \nTry again later"
        case ERROR_PasswordIncorrect:
            return "Password incorrect"
        case ERROR_UserAlreadyLogged:
            return "User already logged"
        case ERROR_EmailNotExist:
            return "email not exist"
        case ERROR_UserNotExist:
            return "User not exist"
        case ERROR_UserExist:
            return "User exist"
        case ERROR_emailExist:
            return "Email exist"
        case ERROR_PlayerNameExist:
            return "Player name exist"
        case SUCCES:
            return "OK"
        default:
            return "Default error... WTF?"
        }
    }
    
    func showAlert(view: UIViewController, titles: String, messages: String){
        var alert = UIAlertController(title: titles, message: messages, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction!)in
        }))
        alert.view.backgroundColor = UIColor.blueColor()
        view.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showAlertDefeated(view: UIViewController, titles: String, messages: String){
        var alert = UIAlertController(title: titles, message: messages, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction!)in
            view.performSegueWithIdentifier("goto_menu", sender: self)
        }))
        alert.view.backgroundColor = UIColor.redColor()
        view.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showAlertWin(view: UIViewController, titles: String, messages: String){
        var alert = UIAlertController(title: titles, message: messages, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction!)in
            view.performSegueWithIdentifier("goto_menu", sender: self)
        }))
        alert.view.backgroundColor = UIColor.greenColor()
        view.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showAlertDraw(view: UIViewController, titles: String, messages: String){
        var alert = UIAlertController(title: titles, message: messages, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction!)in
            view.performSegueWithIdentifier("goto_menu", sender: self)
        }))
        alert.view.backgroundColor = UIColor.blueColor()
        view.presentViewController(alert, animated: true, completion: nil)
    }
    
    func noConnectionAlert(view: UIViewController){
        var alert = UIAlertController(title: "There's no connection here!", message: "Try to connect again please reviewing your settings.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction!)in
        }))
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction!)in
            self.settings()
        }))
        alert.view.backgroundColor = UIColor.redColor()
        view.presentViewController(alert, animated: true, completion: nil)
    }
    
    func noConnectionAlertAndGoToLogin(view: UIViewController){
        var alert = UIAlertController(title: "There's no connection here!", message: "Try to connect again please reviewing your settings.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction!)in
            view.performSegueWithIdentifier("goto_login", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction!)in
            view.performSegueWithIdentifier("goto_login", sender: self)
            self.settings()
        }))
        alert.view.backgroundColor = UIColor.redColor()
        view.presentViewController(alert, animated: true, completion: nil)
    }
    
    func settings(){
        UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
    }

    
    /* Maths */
    func getIntValueBetween(min: Int, max: Int)->Int {
        return Int(arc4random_uniform(UInt32((max - min) + min)))
    }
    
    func getDefaultStats(classType:Int)->[Int]{
     
        var life: Double
        var energy: Double
        var eReg: Double
        var str: Double = BASE_CALC/2
        var intll: Double = BASE_CALC/2
    
        for(var x: Double = 0; x < RAND_CALC; x++){
    
          var val: Int = getIntValueBetween(1,max: 15)
            
            switch (classType) {
            case WARLOCK:
                if (val <= 10){
                    str++
                }else{
                    intll++
                }
                break
            case MAGE:
                if (val <= 10){
                    intll++
                }else{
                    str++
                }
                break
            default:
                break
            }
        }
    
        life = 100.0 + str * LIFE_INTEL_PERCENT
        energy = 100.0 + intll * LIFE_INTEL_PERCENT
        eReg = Double(energy) * 0.1
        var arrayInt = [Int(life),Int(energy),Int(eReg),Int(str),Int(intll)]
        
        return arrayInt
    }
    
    func getDefaultsStats(strength_points: Int, intelligence_points: Int )->[Int] {
        
        var life: Double
        var energy: Double
        var eReg: Double
        var str: Double = Double(strength_points)
        var intll: Double = Double(intelligence_points)
        
        
        life = 100.0 + str * LIFE_INTEL_PERCENT
        energy = 100.0 + intll * LIFE_INTEL_PERCENT
        eReg = Double(energy) * 0.1
        
        var arrayInt = [Int(life),Int(energy),Int(eReg),Int(str),Int(intll)]
        
        return arrayInt
    }

}