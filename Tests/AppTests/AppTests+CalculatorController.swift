//
//  File.swift
//  
//
//  Created by Jose E on 8/12/22.
//

@testable import App
import XCTVapor

extension AppTests {
    func testAddition() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "addition/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "10")
        })
        try app.test(.GET, "addition/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotEqual(res.body.string, "6")
        })
        try app.test(.GET, "addition/hola", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
        try app.test(.GET, "addition", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
    
    func testSubstraction() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "subtraction/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "6")
        })
        try app.test(.GET, "subtraction/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotEqual(res.body.string, "10")
        })
        try app.test(.GET, "subtraction/hola", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
        try app.test(.GET, "subtraction", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
    
    func testMultiplication() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "multiplication/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "16")
        })
        try app.test(.GET, "multiplication/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotEqual(res.body.string, "10")
        })
        try app.test(.GET, "multiplication/hola", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
        try app.test(.GET, "multiplication", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
    
    func testDivision() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "division/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "4")
        })
        try app.test(.GET, "division/8/2", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotEqual(res.body.string, "10")
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
