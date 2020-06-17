//
//  ARSCNView.swift
//  SizyApp
//
//  Created by 임명준 on 2020/04/30.
//  Copyright © 2020 임명준. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

extension ARSCNView {
    //scenePosition인 CGPoint를 SCNVector3로 전환
    func realWorldVector(screenPosition: CGPoint) -> SCNVector3? {
        /*
            hitTest
            @discussion A 2D point in the view’s coordinate space can refer to any point along a line segment in the 3D coordinate space.
            Hit-testing is the process of finding objects in the world located along this line segment.
            @param point A point in the view’s coordinate system.
         
         @return 3D position in world coordinates or a NAN values if unprojection is not possible.
         */
        let results = self.hitTest(screenPosition, types: [.featurePoint])
        guard let result = results.first else { return nil }
        return SCNVector3.positionFromTransform(result.worldTransform)
    }
}
