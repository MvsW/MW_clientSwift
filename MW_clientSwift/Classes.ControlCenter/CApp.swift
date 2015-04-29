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
    
    func startLoading(uiView:UIView, text:String, size2:CGFloat)->[UIView] {
        var container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(red: 75, green: 75, blue: 75, alpha: 0.5)
        
        var loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 150, 100)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 1.3);
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = text
        label.font = UIFont(name: "Helvetica", size: size2)
        
        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 2.5);
        actInd.color = UIColor.redColor()
        
        loadingView.addSubview(actInd)
        loadingView.addSubview(label)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
        
        var views:[UIView] = [loadingView,container]
        return views
    }
    
    func stopLoading(views:[UIView]){
        views[0].removeFromSuperview()
        views[1].removeFromSuperview()
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