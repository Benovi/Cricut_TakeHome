//
//  ShapeViewModel.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//
import Foundation

struct ShapeViewModel: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let drawPath: ShapeStyle
}
