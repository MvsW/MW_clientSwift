//
//  CApp.swift
//  MW_clientSwift
//
//  Created by Black Castle on 11/2/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import Foundation
import UIKit

public class CApp {
    var myController = MyViewController()
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) {
            return emailTest.evaluateWithObject(testStr)
        }
        return false
    }
    
    func isValidPassword(testStr:String) -> Bool{
        if(countElements(testStr) >= 6){
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
    
    //Comprovar que los campos no esten vacios
    //Comprovar que el nombre del jugador sea correcto
    
    func validatePlayerName(text:String) ->Bool{
        let maxValue = 12;
        
        for character in text {
            if(character == "@" || character == " " ){
                return false
            }
            if(character.hashValue >= maxValue){
                return false
            }
        }
        //Pasarlo todo a misusculas para asegurar errores
        for chr in text{
            var str = String(chr)
            if str.lowercaseString == str{
                return true
            }
        }
        return false
    }
    
    // COMPROVAR CONEXIO
    let reachability = Reachability.reachabilityForInternetConnection()

    func comprovarConexion()->Bool{
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
}