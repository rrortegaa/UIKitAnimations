//
//  ViewController.swift
//  Gradients
//
//  Created by Rose on 08/09/23.
//

import UIKit

class ViewController: UIViewController {
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        animateGradientColor()
        // animateGradientLocations()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.animateGradientDirection()
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 6) {
                self.animateSecondGradientDirection()
            }
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 12) {
                self.animateOtherGradientDirection()
            }
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 18) {
                self.animateLastGradientDirection()
            }
        }
    }
    
    func createGradientLayer() {
        /* Define los colores y los puntos del gradiente */
        // let colors: [CGColor] = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        let colors: [CGColor] = [UIColor.green.cgColor, UIColor.white.cgColor, UIColor.red.cgColor]
        let startPoint = CGPoint(x: 1.0, y: 0.0) // Lo estamos cambiando, para una diagonal debe ser 0.0, 0.0
        let endPoint = CGPoint(x: 1.0, y: 1.0)
        let locations: [NSNumber] = [0.0, 0.5, 1.0]
        
        /* Asigna sus atributos al gradiente */
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
        
        /* Configura la posición y el tamaño del gradiente */
        gradientLayer.frame = view.bounds
        
        /* Agrega la capa de gradiente a la vista */
        view.layer.addSublayer(gradientLayer)
    }
    
    func animateGradientColor() {
        /* Define los colores finales del gradiente */
        let finalColors: [CGColor] = [UIColor.systemPink.cgColor, UIColor.systemYellow.cgColor, UIColor.systemOrange.cgColor]
        
        /* Crea una animaci{on CABasicAnimation para animar el cambio de colores */
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = finalColors
        animation.duration = 5.0
        
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "colorAnimation")
    }
    
    func animateGradientLocations() {
        /* Crea una animación CABasicAnimation para animar el cambio de ubicaiones */
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = gradientLayer.locations // Valor inicial
        animation.toValue = [0.0, 0.5, 1.0] // Valor final
        animation.duration = 5.0
        
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        /* Aplica la animación al gradient layer */
        gradientLayer.add(animation, forKey: "locationsAnimation")
    }
    
    /* Rotación del gradiente */
    /*
     (1, 0)
     (1, 1)
     
     (0, 1)
     (1, 1)
     
     (0, 1)
     (0, 0)
     
     (1, 0)
     (0, 0)
    */
    
    func animateGradientDirection() {
        /* Crea una animación CABasicAnimation para animar el cambio de startPoint y endPoint */
        let animation = CABasicAnimation(keyPath: "startPoint")
        animation.fromValue = gradientLayer.startPoint
        animation.toValue = CGPoint(x: 0.0, y: 1.0) // start (0, 1) y end(1, 1)
        animation.duration = 5.0
        
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "startPointAnimation")
    }
    
    func animateSecondGradientDirection() {
        let animation = CABasicAnimation(keyPath: "endPoint")
        //animation.fromValue = CGPoint(x: 1.0, y: 0.0)
        //animation.toValue = gradientLayer.endPoint
        animation.fromValue = gradientLayer.endPoint
        animation.toValue = CGPoint(x: 0.0, y: 0.0) // start (0, 1) y end(0, 0)
        animation.duration = 5.0
        
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "endPointAnimation")
    }
    
    func animateOtherGradientDirection() {
        let animation = CABasicAnimation(keyPath: "startPoint")
        animation.fromValue = gradientLayer.endPoint
        animation.toValue = CGPoint(x: 1.0, y: 0.0) // start (1, 0) y end(0, 0)
        animation.duration = 5.0
        
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "startPointAnimation2")
    }
    
    func animateLastGradientDirection() {
        let animation = CABasicAnimation(keyPath: "endPoint")
        animation.fromValue = gradientLayer.endPoint
        animation.toValue = CGPoint(x: 1.0, y: 1.0) // start (1, 0) end(1, 1)
        animation.duration = 5.0
        
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "endPointAnimation2")
    }

}
