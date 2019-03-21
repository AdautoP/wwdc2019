//
//  RandomWalkBehavior.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 15/03/19.
//

import UIKit
import GameplayKit

class MoveBehavior: GKBehavior {
    init(targetSpeed: Float? = nil, seek: GKAgent? = nil, avoid: [GKAgent]? = nil, shouldWander: Bool = false, shouldStay: Bool = false, bounds: CGRect? = nil) {
        super.init()
        if let targetSpeed = targetSpeed{
            setWeight(0.2, for: GKGoal(toReachTargetSpeed: targetSpeed))
        }
        
        if let seek = seek{
            setWeight(0.3, for: GKGoal(toSeekAgent: seek))
        }
        if let avoid = avoid{
            setWeight(0.4, for: GKGoal(toAvoid: avoid, maxPredictionTime: 1.0))
        }
        if shouldWander{
            if let bounds = bounds{
                let point1 = float2(x: Float(bounds.midX), y: Float(bounds.midY))
                let point2 = float2(x: Float(bounds.midX+1), y: Float(bounds.midY+1))
                setWeight(1.0, for: GKGoal(toStayOn: GKPath(points: [point1,point2], radius: 250, cyclical: true), maxPredictionTime: 0))
            }
        }
        if shouldStay{
            //
        }
    }
}
