//
//  Extensions.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//
import Foundation

extension Array {
    func arrangeGrid(into size: Int = 3) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
