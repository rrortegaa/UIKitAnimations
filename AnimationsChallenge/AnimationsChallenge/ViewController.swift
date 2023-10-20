//
//  ViewController.swift
//  AnimationsChallenge
//
//  Created by Rose on 12/09/23.
//

import UIKit
import SceneKit


class ViewController: UIViewController {
    let gradientLayer = CAGradientLayer()
    // let highwayLayer = CAGradientLayer()
    let moon: UIImageView = UIImageView()
    let highway: UIImageView = UIImageView()
    let bodywork = UIView()
    let wheel: UIImageView = UIImageView()
    var constraintsToAnimate: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneView = SCNView(frame: self.view.frame)
        self.view.addSubview(sceneView)

        let scene = SCNScene()
        sceneView.scene = scene
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0.75, y: 0.75, z: 10.0)
        
        let bodyworkGeometry = SCNBox(width: 1.5, height: 1.0, length: 1.0, chamferRadius: 0.0)
        let cubeNode = SCNNode(geometry: bodyworkGeometry)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue.withAlphaComponent(0.9)
        bodyworkGeometry.materials = [material]
        
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(cubeNode)
        
        createGradientLayer()
        setupUI()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.animateGradientColors()
            self.moonRotationAnimation()
            self.carAnimation()
        }
    }

    func createGradientLayer() {
        let colors: [CGColor] = [UIColor.black.cgColor, UIColor.systemIndigo.cgColor, UIColor.systemPurple.cgColor]
        let startPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: 0.0, y: 1.0)
        let locations: [NSNumber] = [0.0, 0.45, 1.0]
        
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
        gradientLayer.frame = view.bounds
        view?.layer.addSublayer(gradientLayer)
    }
    
    func setupUI() {
       
        moon.translatesAutoresizingMaskIntoConstraints = false
        moon.image = UIImage(named: "Moon")
        moon.contentMode = .center
        view.addSubview(moon)
        
        highway.image = UIImage(named: "Road")
        highway.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(highway)
        
        bodywork.backgroundColor = .blue
        bodywork.layer.cornerRadius = 8
        bodywork.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bodywork)
        
        // wheel.backgroundColor = .black
        wheel.image = UIImage(named: "Wheel")
        // wheel.layer.cornerRadius = 10
        wheel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wheel)
        
        constraintsToAnimate = bodywork.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        NSLayoutConstraint.activate([
            constraintsToAnimate!,
            moon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            moon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            moon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            moon.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            highway.topAnchor.constraint(equalTo: moon.bottomAnchor, constant: 100),
            highway.widthAnchor.constraint(equalTo: view.widthAnchor),
            highway.heightAnchor.constraint(equalToConstant: 175),
            
            // body.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bodywork.topAnchor.constraint(equalTo: moon.bottomAnchor, constant: 50),
            bodywork.widthAnchor.constraint(equalToConstant: 110),
            bodywork.heightAnchor.constraint(equalToConstant: 60),
            
            // wheel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            wheel.centerXAnchor.constraint(equalTo: bodywork.centerXAnchor),
            wheel.widthAnchor.constraint(equalToConstant: 60),
            wheel.heightAnchor.constraint(equalToConstant: 60),
            wheel.topAnchor.constraint(equalTo: bodywork.bottomAnchor, constant: 1)
        ])
    }
    
    func animateGradientColors() {
        let finalColors: [CGColor] = [UIColor.systemOrange.cgColor, UIColor.systemPink.cgColor, UIColor.systemYellow.cgColor]
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = finalColors
        animation.duration = 10.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "colorAnimation")
    }
    
    func moonRotationAnimation() {
        let moonrotation = CABasicAnimation(keyPath: "transform.rotation.z")
        moonrotation.fromValue = 0.0
        moonrotation.toValue = .pi * 2.0
        moonrotation.duration = 20.0
        moonrotation.repeatCount = .infinity
        moon.layer.add(moonrotation, forKey: "moonRotation")
    }
    
    func carAnimation() {
        UIView.animate(withDuration: 4, delay: 4, options: .repeat) {
            self.constraintsToAnimate?.constant += 300
            self.wheel.transform = CGAffineTransform(rotationAngle: .pi / 3)
            self.view.layoutIfNeeded()
        }
        /* completion: { _ in
            UIView.animate(withDuration: 6) {
                self.constraintsToAnimate?.constant -= 500
                self.wheel.transform = CGAffineTransform(rotationAngle: .pi / -3)
                self.view.layoutIfNeeded()
            }
        } */
    }
    
    
    /*
    func createHighwayLayer() {
        let colors: [CGColor] = [UIColor.black.cgColor, UIColor.systemIndigo.cgColor, UIColor.darkGray.cgColor]
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 0, y: 1)
        
        highwayLayer.colors = colors
        highwayLayer.startPoint = startPoint
        highwayLayer.endPoint = endPoint
        // highwayLayer.locations = locations
        highwayLayer.frame = CGRect(x: 0, y: 400, width: 250, height: 80)
        highwayLayer.frame = view.frame
        highwayLayer.repeatCount = .infinity
        view?.layer.addSublayer(highwayLayer)
    }
    
    func animateHighwayLayer() {
        let finalColors: [CGColor] = [UIColor.black.cgColor, UIColor.systemIndigo.cgColor, UIColor.darkGray.cgColor]
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = highwayLayer.colors
        animation.toValue = finalColors
        animation.duration = 10.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        highwayLayer.add(animation, forKey: "colorAnimation")
    }
    */
    
}
