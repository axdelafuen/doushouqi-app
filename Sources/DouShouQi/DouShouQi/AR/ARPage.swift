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
        
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        
        //let anchorEntity = AnchorEntity(world: .zero)
        let anchorEntity = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        arView.scene.addAnchor(anchorEntity)
        
        let usdzModel = try! Entity.loadModel(named: "board")
        anchorEntity.addChild(usdzModel)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update the ARView if needed
    }
}
