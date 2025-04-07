//
//  EditCircleViewModelTests.swift
//  TakeHome_CricutTests
//
//  Created by Ben Oveson on 4/7/25.
//
import SwiftUI
import XCTest
@testable import TakeHome_Cricut

@MainActor
final class EditCircleViewModelTests: XCTestCase {

    func test_DeleteAll() {
        let viewModel = EditCircleViewModel(shapeViewModels: threeCircleViewModels, onDone: {_ in})

        viewModel.deleteAll()

        XCTAssertTrue(viewModel.circleViewModels.isEmpty)
    }

    func test_AddOne() {
        let viewModel = EditCircleViewModel(shapeViewModels: threeCircleViewModels, onDone: {_ in})

        viewModel.addOne()

        XCTAssertTrue(viewModel.circleViewModels.count == 4)
    }

    func test_RemoveOne() {
        let viewModel = EditCircleViewModel(shapeViewModels: threeCircleViewModels, onDone: {_ in})

        viewModel.removeOne()

        XCTAssertTrue(viewModel.circleViewModels.count == 2)
    }
}


private let threeCircleViewModels: [ShapeViewModel] = [.init(drawPath: .circle),
                                                       .init(drawPath: .circle),
                                                       .init(drawPath: .circle)]

