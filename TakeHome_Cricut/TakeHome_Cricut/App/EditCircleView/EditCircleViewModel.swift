//
//  EditCircleViewModel.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//
import Foundation
import SwiftUI

class EditCircleViewModel: ObservableObject {
    
    private var shapeViewModels: [ShapeViewModel]
    @Published var circleViewModels: [ShapeViewModel] = []
    var onDone: (([ShapeViewModel]) -> Void)
    
    init(shapeViewModels: [ShapeViewModel],
         onDone: @escaping (([ShapeViewModel]) -> Void)) {
        self.shapeViewModels = shapeViewModels
        self.onDone = onDone
        self.makeCircleViewModels()
    }
    
    func deleteAll() {
        let circleIDs: [String]  = getCircleIds(shapes: shapeViewModels)
        removeCircles(ids: circleIDs)
        makeCircleViewModels()
    }
    
    func addOne() {
        shapeViewModels.append(ShapeViewModel(drawPath: .circle))
        makeCircleViewModels()
    }
    
    func removeOne() {
        let circleIDs: [String] = getCircleIds(shapes: shapeViewModels)
        if let lastID = circleIDs.last  {
            removeCircles(ids: [lastID])
        }
    }
    
    func removeCircles(ids: [String]) {
        
        guard ids.isEmpty == false else {
            return
        }
        
        let newArray: [ShapeViewModel] = shapeViewModels.compactMap {
            if ids.contains($0.id) {
                return nil
            } else {
                return $0
            }
        }
        
        self.shapeViewModels = newArray
        makeCircleViewModels()
    }
    
    func getCircleIds(shapes: [ShapeViewModel]) -> [String] {
       shapes.compactMap {
            if case .circle = $0.drawPath {
                return $0.id
            } else {
                return nil
            }
        }
    }
    
    func makeCircleViewModels() {
        circleViewModels = shapeViewModels.filter { $0.drawPath == .circle }
    }
    
    func done() {
        onDone(shapeViewModels)
    }
}

extension EditCircleViewModel: Hashable {
    static func == (lhs: EditCircleViewModel, rhs: EditCircleViewModel) -> Bool {
        return lhs === rhs
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
