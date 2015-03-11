//
//  VCResgiter_player.swift
//  MW_clientSwiftDesign
//
//  Created by Black Castle on 15/2/15.
//  Copyright (c) 2015 MW. All rights reserved.

import UIKit

class VCRegister_player: UIViewController, UIScrollViewDelegate {
    
    // DECLARACIO BOTONS
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var sumaStrenght: UIButton!
    @IBOutlet weak var restaStrenght: UIButton!
    @IBOutlet weak var sumaInteligence: UIButton!
    @IBOutlet weak var restaInteligence: UIButton!
    @IBOutlet weak var tfStrenght: UITextField!
    @IBOutlet weak var tfInteligence: UITextField!
    @IBOutlet weak var tfPoints: UITextField!
    @IBOutlet weak var tfLife: UITextField!
    @IBOutlet weak var tfEnergy: UITextField!
    @IBOutlet weak var tfEnergyRegeneration: UITextField!
    

    // DECLARACIO VARIABLES
    var containerView: UIView!
    var pointsLife = 0
    var pointsEnergy = 0
    var pointsEnergyRegeneration = 0
    var pointsStrenght = 0
    var pointsInteligence = 0
    var pointsPoints = 0
    let MAXPOINTS_STRENGHT = 5
    let MINPOINTS_STRENGHT = 1
    let MAXPOINTS_INTELIGENCE = 5
    let MINPOINTS_INTELIGENCE = 1

    // METODES BOTONS
    @IBAction func sumaStrenght(sender: UIButton) {
        println("sumaStrength")
        if(tfStrenght.text.toInt() <= MAXPOINTS_STRENGHT){
            pointsStrenght = pointsStrenght + 1
            tfStrenght.text = pointsStrenght.description
        }
    }
    @IBAction func restaStrenght(sender: UIButton) {
        println("restaStrength")
        if(tfStrenght.text.toInt() >= MINPOINTS_STRENGHT){
            pointsStrenght = pointsStrenght - 1
            tfStrenght.text = pointsStrenght.description
        }
    }

    @IBAction func sumaInteligence(sender: UIButton) {
        println("sumaInteligence")
        if(tfInteligence.text.toInt() <= MAXPOINTS_INTELIGENCE){
            pointsInteligence = pointsInteligence + 1
            tfInteligence.text = pointsInteligence.description
        }
    }
    @IBAction func restaInteligence(sender: UIButton) {
        println("restaInteligence")
        if(tfInteligence.text.toInt() >= MINPOINTS_INTELIGENCE){
            pointsInteligence = pointsInteligence - 1
            tfInteligence.text = pointsInteligence.description
        }
    }
    @IBAction func create(sender: UIButton) {
        println("create OK")
    }
    
    
    
    // METODES CONTROLLER-VIEW
    @IBAction func createTapped(sender: UIButton) {
        //Checkejar els camps, si son correctes enviar al servidor i espera resposta
        //Si el server diu OK pasem a menu
        if(true){
            self.performSegueWithIdentifier("goto_menu", sender: self)
        }
//TODO cambiar el nom de la variable a comprobar
        //Validar camps i enviar al servidor
        let validarUsuari: Bool = application.validateUserName("NombreDeLaVariable")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the container view to hold your custom view hierarchy
        //let containerSize = CGSizeMake(640.0, 640.0)
        let containerSize = CGSizeMake(0, self.view.frame.height * 1.7)
        
        containerView = UIView(frame: CGRect(origin: CGPointMake(0.0, 0.0), size:containerSize))
        scrollView.addSubview(containerView)
        
        // Tell the scroll view the size of the contents
        scrollView.contentSize = containerSize;
        
        // Set up the minimum & maximum zoom scale
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        
        centerScrollViewContents()
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        containerView.frame = contentsFrame
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return containerView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView!) {
        centerScrollViewContents()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

