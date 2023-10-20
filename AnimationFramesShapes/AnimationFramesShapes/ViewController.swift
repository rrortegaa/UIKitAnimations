//
//  ViewController.swift
//  AnimationFramesShapes
//
//  Created by Rose on 07/09/23.
//

import UIKit

enum keyPathAnimation: String {
    case path = "path"
    case strokeColor = "strokeColor"
    case fillColor = "fillColor"
}

class ViewController: UIViewController {
  /*
    let shapeLayer = CAShapeLayer()
    let path = UIBezierPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCustomShape()
        animateShapeChange()
        animateStrokeColorChange()
        animateFillColorChange()
    }
    
    func createCustomShape() {
        path.move(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 200))
        path.addLine(to: CGPoint(x: 200, y: 100))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.close()
        
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 4.0
        
        view.layer.addSublayer(shapeLayer)
    }
    
    func animateShapeChange() {
        /* Crea un nuevo UIBezierPath para la forma de destino */
        let newPath = UIBezierPath()
        newPath.move(to: CGPoint(x: 100, y: 100))
        newPath.addLine(to: CGPoint(x: 300, y: 100))
        newPath.addLine(to: CGPoint(x: 150, y: 300))
        newPath.close()
        
        /* Crea una animación de forma */
        let shapeAnimation = CABasicAnimation(keyPath: keyPathAnimation.path.rawValue)
        shapeAnimation.toValue = newPath.cgPath
        shapeAnimation.duration = 2.0
        shapeAnimation.fillMode = .forwards
        shapeAnimation.isRemovedOnCompletion = false
        
        /* Aplica la animación a la CAShapeLAyer existente */
        shapeLayer.add(shapeAnimation, forKey: "pathAnimation")
    }
    
    func animateStrokeColorChange() {
        let strokeAnimation = CABasicAnimation(keyPath: keyPathAnimation.strokeColor.rawValue)
        strokeAnimation.toValue = UIColor.systemMint.cgColor
        strokeAnimation.duration = 2.0
        strokeAnimation.fillMode = .forwards
        strokeAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(strokeAnimation, forKey: "strokeColorAnimation")
    }

    func animateFillColorChange() {
        let fillAnimation = CABasicAnimation(keyPath: keyPathAnimation.fillColor.rawValue)
        fillAnimation.toValue = UIColor.systemIndigo.cgColor
        fillAnimation.duration = 2.0
        fillAnimation.fillMode = .forwards
        fillAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(fillAnimation, forKey: "fillColorAnimation")
    }
*/
    
    /* Ejemplos de la primer parte de la clase */
    
    // let square = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    let square = UIView()
    let square2 = UIView()
    var constraintToAnimate: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.startAnimations()
        }
        // startAnimations()
    }

    func setupUI() {
        // square.center = view.center
        square.backgroundColor = .orange
        square.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(square)
        
        square2.backgroundColor = .systemMint
        square2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(square2)
        
        constraintToAnimate = square.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        NSLayoutConstraint.activate([
            constraintToAnimate!,
            square.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            square.widthAnchor.constraint(equalToConstant: 70),
            square.heightAnchor.constraint(equalToConstant: 70),
            
            // square2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            square2.centerXAnchor.constraint(equalTo: square.centerXAnchor),
            square2.widthAnchor.constraint(equalToConstant: 50),
            square2.heightAnchor.constraint(equalToConstant: 50),
            square2.topAnchor.constraint(equalTo: square.bottomAnchor, constant: 25)
        ])
    }

    func startAnimations() {
        // UIView.animate(withDuration: 4, delay: 1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.25) {
            /*
            self.square.frame.origin.x += 50
            self.square.frame.origin.y += 100
            self.square.frame.size = .init(width: 150, height: 150)
            self.square.center = self.view.center
            */
            
            /* self.square.frame = CGRect(x: 100, y: 50, width: 150, height: 150) */
            
            /* self.square.transform = CGAffineTransform(rotationAngle: .pi / 4).scaledBy(x: 2.0, y: 2.0).translatedBy(x: 100, y: 100) */
            
        UIView.animate(withDuration: 4) {
            self.constraintToAnimate?.constant += 100
            self.square2.transform = CGAffineTransform(rotationAngle: .pi / 3)
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.constraintToAnimate?.constant -= 200
            self.square2.transform = CGAffineTransform(rotationAngle: .pi / -3)
            self.view.layoutIfNeeded()
        }
    }
     // Fin de ejemplos de primer parte de la clase
}

