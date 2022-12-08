//
//  File.swift
//  
//
//  Created by Jose E on 8/12/22.
//

import Vapor

struct CalculatorController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("addition") { route in
            route.get("**", use: addition)
        }
        routes.group("subtraction") { route in
            route.get("**", use: subtraction)
        }
        routes.group("multiplication") { route in
            route.get("**", use: multiplication)
        }
        routes.group("division") { route in
            route.get("**", use: division)
        }
        routes.group("squareRoot") { route in
            route.get(":num", use: squareRoot)
        }
    }
    
    func operate(operation: Operations, req: Request) async throws -> Int {
        var numbers: [String] = req.parameters.getCatchall()
        guard let firstValue = numbers.first, let firstValue = Int(firstValue) else { throw Abort(.badRequest) }
        numbers.removeFirst()
        let total = try numbers.reduce(firstValue, {
            guard let num2 = Int($1) else { throw Abort(.badRequest) }
            switch operation {
            case Operations.Addition:
                return $0 + num2
            case Operations.Substraction:
                return $0 - num2
            case Operations.Multiplication:
                return $0 * num2
            case Operations.Division:
                return $0 / num2
            default:
                return 0
            }
        } )
        return total
    }
    
    func addition(req: Request) async throws -> Int {
        try await operate(operation: .Addition, req: req)
    }
    
    func subtraction(req: Request) async throws -> Int {
        try await operate(operation: .Substraction, req: req)
    }
    
    func multiplication(req: Request) async throws -> Int {
        try await operate(operation: .Multiplication, req: req)
    }
    
    func division(req: Request) async throws -> Int {
        try await operate(operation: .Division, req: req)
    }
    
    func squareRoot(req: Request) async throws -> Float {
        guard let number: Float = req.parameters.get("num", as: Float.self) else {
            throw Abort(.badRequest)
        }
        return number.squareRoot()
    }
}
