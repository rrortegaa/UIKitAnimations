//
//  ViewController.swift
//  3DAnimations
//
//  Created by Rose on 11/09/23.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneView = SCNView(frame: self.view.frame)
        self.view.addSubview(sceneView)
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        let light = SCNLight()
        light.type = SCNLight.LightType.omni
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: 2, y: 2, z: 2)
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0.75, y: 0.75, z: 6.0)
        
        let cubeGeometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        let cubeNode = SCNNode(geometry: cubeGeometry)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green.withAlphaComponent(0.85) // Cambia el color de las paredes
        
        /* Aplica el material a la geometría */
        cubeGeometry.materials = [material]
        
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(cubeNode)
        
        /* Animación de rotación */
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat.pi * 2, z: 0, duration: 4.0)
        let repeatRotation = SCNAction.repeatForever(rotation)
        cubeNode.runAction(repeatRotation)
        
        /* Animación de escalado */
        let scaleUp = SCNAction.scale(by: 2.0, duration: 1.0) // Escala el cubo al doble de su tamaño original
        let scaleDown = SCNAction.scale(by: 0.5, duration: 1.0) // Reduce el cubo a la mitad de su tamaño original en 1 segundo
        let scaleSequence = SCNAction.sequence([scaleUp, scaleDown]) // Secuencia de escalado
        let repeatScale = SCNAction.repeatForever(scaleSequence) // Repetir la secuencia de esclado continuamente
        cubeNode.runAction(repeatScale)
        
        /* Animación de posición del cubo */
        let newPosition = SCNVector3(0.0, 2.0, 0.0) // Nueva posición del cubo
        let moveAction = SCNAction.move(to: newPosition, duration: 2.0) // Animación para mover el cubo a la nueva posición durante 2 segundos
        moveAction.reversed()
        cubeNode.runAction(moveAction) // Aplicar la animación al nodo del cubo
    }
}

