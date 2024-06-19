//
//  ARPage.swift
//  DouShouQi
//
//  Created by etudiant on 14/06/2024.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configure AR session
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        
        // Create an anchor and add the model to it
        let anchorEntity = AnchorEntity(world: .zero)
        arView.scene.addAnchor(anchorEntity)
        
        // Load the USDZ model
        let usdzModel = try! Entity.loadModel(named: "board")
    
        anchorEntity.addChild(usdzModel)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update the ARView if needed
    }
}
