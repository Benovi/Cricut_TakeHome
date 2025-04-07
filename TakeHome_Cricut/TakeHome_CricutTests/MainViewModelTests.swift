//
//  TakeHome_CricutTests.swift
//  TakeHome_CricutTests
//
//  Created by Ben Oveson on 4/6/25.
//

import XCTest
@testable import TakeHome_Cricut

@MainActor
final class MainViewModelTests: XCTestCase {

    func testClearAllShapes() {
        let shape = ShapeViewModel(drawPath: .circle)
        let viewModel = MainViewModel(shapes: [shape])

        viewModel.clearAll()

        XCTAssertTrue(viewModel.shapes.isEmpty)
    }

    func testAddShapeAppendsNewShape() {
        let viewModel = MainViewModel()

        viewModel.addShape(.triangle)

        XCTAssertEqual(viewModel.shapes.count, 1)
        XCTAssertEqual(viewModel.shapes.first?.drawPath, .triangle)
    }

    func testLoadSuccessSetsShapeButtons() async {
        let mockProvider = MockDataProvider()
        let mockButton = EditShapeButtonViewModel(name: "Circle", drawPath: .circle)
        mockProvider.mockButtons = [mockButton]
        let viewModel = MainViewModel(dataProvider: mockProvider)

        await viewModel.load()

        XCTAssertEqual(viewModel.editshapeButtons.count, 1)
        XCTAssertEqual(viewModel.editshapeButtons.first?.drawPath, .circle)
        XCTAssertFalse(viewModel.error)
    }

    func testLoadFailureSetsErrorFlag() async {
        let mockProvider = MockDataProvider()
        mockProvider.shouldFail = true
        let viewModel = MainViewModel(dataProvider: mockProvider)

        await viewModel.load()

        XCTAssertTrue(viewModel.error)
        XCTAssertTrue(viewModel.editshapeButtons.isEmpty)
    }
}


class MockDataProvider: MainViewDataProvider {
    var shouldFail = false
    var mockButtons: [EditShapeButtonViewModel] = []

    override func fetchShapeButtons() async throws -> [EditShapeButtonViewModel] {
        if shouldFail {
            throw MainViewDataProviderError.failedToDecode
        } else {
            return mockButtons
        }
    }
}
