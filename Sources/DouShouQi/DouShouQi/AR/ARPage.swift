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
            configuration.planeDetection = [.horizontal, .vertical]
            arView.session.run(configuration)
            
            // Load the USDZ model
            let usdzModel = try! Entity.loadModel(named: "cat")
        
            // Create an anchor and add the model to it
            let anchorEntity = AnchorEntity()
            anchorEntity.addChild(usdzModel)
            
            // Add the anchor to the scene
            arView.scene.anchors.append(anchorEntity)
            
            return arView
        }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update the ARView if needed
    }
}

struct ARPage: View {
    var body: some View {
        ARViewContainer()
                    .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ARPage()
}
