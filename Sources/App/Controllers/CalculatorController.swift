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
        let numbers: [String] = req.parameters.getCatchall()
        var returnValue: Int?
        try numbers.forEach { num in
            guard let num = Int(num) else {
                throw Abort(.badRequest)
            }
            if returnValue != nil{
                switch operation {
                case Operations.Addition:
                    returnValue! += num
                case Operations.Substraction:
                    returnValue! -= num
                case Operations.Multiplication:
                    returnValue! *= num
                case Operations.Division:
                    returnValue! /= num
                default:
                    break
                }
            } else {
                returnValue = num
            }
        }
        guard let returnValue else {
            throw Abort(.internalServerError)
        }
        return returnValue
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
