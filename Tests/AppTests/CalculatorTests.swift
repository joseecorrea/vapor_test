//
//  File.swift
//  
//
//  Created by Jose E on 8/12/22.
//

@testable import App
import XCTVapor

final class CalculatorTests: XCTestCase {
    
    var app: Application?
    var capturingViewRender: CalculatorViewRenderer?

    override func setUpWithError() throws {
        app = Application(.testing)
        guard let app else { return }
        try configure(app)
        capturingViewRender = CalculatorViewRenderer(eventLoop: app.eventLoopGroup.next())
        guard let capturingViewRender else { return }
        app.views.use { _ in capturingViewRender }
    }

    func testAddition() throws {
        guard let app else { return }
        try app.test(.GET, "addition/8/2", afterResponse: { res in
            guard let context = capturingViewRender?.capturedContext as? CalculatorContext else { return }
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(context.returnValue, "10")
        })
        try app.test(.GET, "addition/8/2", afterResponse: { res in
            guard let context = capturingViewRender?.capturedContext as? CalculatorContext else { return }
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotEqual(context.returnValue, "6")
        })
        try app.test(.GET, "addition/hola", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
        try app.test(.GET, "addition", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
    
    func testSubstraction() throws {
        guard let app else { return }
        guard let context = capturingViewRender?.capturedContext as? CalculatorContext else { return }
        try app.test(.GET, "subtraction/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(context.returnValue, "6")
        })
        try app.test(.GET, "subtraction/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotEqual(context.returnValue, "10")
        })
        try app.test(.GET, "subtraction/hola", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
        try app.test(.GET, "subtraction", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
    
    func testMultiplication() throws {
        guard let app else { return }
        guard let context = capturingViewRender?.capturedContext as? CalculatorContext else { return }
        try app.test(.GET, "multiplication/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(context.returnValue, "16")
        })
        try app.test(.GET, "multiplication/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotEqual(context.returnValue, "10")
        })
        try app.test(.GET, "multiplication/hola", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
        try app.test(.GET, "multiplication", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
    
    func testDivision() throws {
        guard let app else { return }
        guard let context = capturingViewRender?.capturedContext as? CalculatorContext else { return }
        try app.test(.GET, "division/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(context.returnValue, "4")
        })
        try app.test(.GET, "division/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotEqual(context.returnValue, "10")
        })
        try app.test(.GET, "division/hola", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
        try app.test(.GET, "division", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
    
    func testSquareRoot() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "squareRoot/15", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "3.872983455657959")
        })
        try app.test(.GET, "squareRoot/15", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotEqual(res.body.string, "10")
        })
        try app.test(.GET, "squareRoot/hola", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
        try app.test(.GET, "squareRoot", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
}
