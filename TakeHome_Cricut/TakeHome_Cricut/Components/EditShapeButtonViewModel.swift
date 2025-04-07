//
//  EditShapeButtonViewModel.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//
import Foundation

struct EditShapeButtonViewModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let drawPath: ShapeStyle
}
