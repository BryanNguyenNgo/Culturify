import UIKit
import RealityKit
import ARKit

class LionDanceView: UIViewController, ARSessionDelegate  {
    
    var arView: ARView!
    var label: UILabel!
    var hasPlacedLionDance = false // Prevent multiple placements
//    let textArray = [
//        "Hello, I am Bryan.",
//        "This is my school.",
//        "I love coding!",
//        "Thanks for reading!"
//    ]
    var textUpdateTimer: Timer?
    var currentIndex = 0
    var actionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize ARView
        arView = ARView(frame: self.view.frame)
        self.view.addSubview(arView)
        
        // Add label
        label = UILabel()
        label.text = "Find a flat surface!"
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            label2.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 250),
            label.heightAnchor.constraint(equalToConstant: 50)

        ])
        
        // Configure AR session with plane detection
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        
        // Set AR session delegate
        arView.session.delegate = self
        
        // Add tap gesture recognizer
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard !hasPlacedLionDance else { return } // Ensure only one Mooncake is placed
            
            for anchor in anchors {
                if let planeAnchor = anchor as? ARPlaneAnchor {
                    // Update label to indicate that the plane was found
                    label.text = "Plane detected! Placing Mooncake..."
                    
                    // Place the Mooncake automatically on the detected plane
                    if let lionDance = createLionDance() {
                        let worldPos = simd_make_float3(planeAnchor.transform.columns.3) // Use the plane's position
                        placeObject(object: lionDance, at: worldPos)
                        
                        hasPlacedLionDance = true // Prevent further placements
                    } else {
                        print("Failed to load Mooncake model")
                    }
                }
            }
        }
    
    
    func createLionDance() -> ModelEntity? {
        guard let lionDanceModel = try? Entity.loadModel(named: "Lion_dance_monster") else {
            print("Failed to load Mooncake model")
            return nil
        }
        lionDanceModel.generateCollisionShapes(recursive: true)
        lionDanceModel.scale = SIMD3<Float>(0.2, 0.2, 0.2)
        return lionDanceModel
    }
    
    func placeObject(object: ModelEntity, at location: SIMD3<Float>) {
        let objectAnchor = AnchorEntity(world: location)
        objectAnchor.addChild(object)
        arView.scene.addAnchor(objectAnchor)
    }

}
