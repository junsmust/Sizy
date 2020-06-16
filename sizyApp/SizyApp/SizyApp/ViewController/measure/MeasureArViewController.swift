//
//  MeasureArViewController.swift
//  SizyApp
//
//  Created by 임명준 on 2020/04/30.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class MeasureArViewController: UIViewController {
    //ar session 관련
    var session = ARSession()
    var sessionConfig = ARWorldTrackingConfiguration()
    var startValue = SCNVector3()
    var endValue = SCNVector3()
    var lines: [Line] = []
    var currentLine: Line?
    var unit: DistanceUnit = .inch
    var isMeasuring:Bool = false
    var vectorZero = SCNVector3()

    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneViewSetup()
        debugPrint("viewDidLoad")
    }
    func sceneViewSetup(){
        sceneView.delegate = self
        sceneView.session = session
        session.run(sessionConfig, options: [.resetTracking, .removeExistingAnchors])
        resetValues()
    }
    
    func resetValues() {
        isMeasuring = false
        startValue = SCNVector3()
        endValue = SCNVector3()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetValues()
        isMeasuring = true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
           isMeasuring = false
           if let line = currentLine {
               lines.append(line)
            debugPrint("lineCount  \(lines.count)")
               currentLine = nil
           }
       }
}
//ARSCNViewDelegate
extension MeasureArViewController:ARSCNViewDelegate{
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        debugPrint("ARSCNViewDelegate renderer")

            DispatchQueue.main.async {
                //self.detectObjects()
            }
        }
        
        func session(_ session: ARSession, didFailWithError error: Error) {
           // messageLabel.text = "Error occured"
        }
        
        func sessionWasInterrupted(_ session: ARSession) {
            //messageLabel.text = "Interrupted"
        }
        
        func sessionInterruptionEnded(_ session: ARSession) {
    //        messageLabel.text = "Interruption ended"
           /* if lines.isEmpty {
                 messageLabel.text = "Hold screen & move your iPhone..."
            }*/
        }
}
extension MeasureArViewController{
    func detectObjects() {
        guard let worldPosition = sceneView.realWorldVector(screenPosition: view.center) else { return }
        debugPrint("detectObjects")
       /* targetImage.isHidden = false
        meterButton.isHidden = false
        rulerImage.isHidden = false
        loadingView.isHidden = true*/
        
        if lines.isEmpty {
           // messageLabel.text = "Hold screen & move your iPhone..."
            debugPrint("Hold screen & move your iPhone...")
        }
        //loadingView.stopAnimating()
        if isMeasuring {
            if startValue == vectorZero {
                startValue = worldPosition
                currentLine = Line(sceneView: sceneView, startVector: startValue, unit: unit)
            }
            endValue = worldPosition
            currentLine?.update(to: endValue)
           // messageLabel.text = currentLine?.distance(to: endValue) ?? "Calculating..."
            //unitLabel.text = messageLabel.text
        }
    }
}
