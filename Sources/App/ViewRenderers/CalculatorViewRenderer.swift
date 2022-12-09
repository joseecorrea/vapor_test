import Vapor

class CalculatorViewRenderer: ViewRenderer {
    var shouldCache = false
    var eventLoop: EventLoop
    init(eventLoop: EventLoop) {
        self.eventLoop = eventLoop
    }
    
    func `for`(_ request: Request) -> ViewRenderer {
        return self
    }

    private(set) var capturedContext: Encodable?
    private(set) var templatePath: String?
    func render<E>(_ name: String, _ context: E) -> EventLoopFuture<View> where E : Encodable {
        self.capturedContext = context
        self.templatePath = name
        let string = "I just want to get the context and the templatePath, I don't care what the view will look like"
        var byteBuffer = ByteBufferAllocator().buffer(capacity: string.count)
        byteBuffer.writeString(string)
        let view = View(data: byteBuffer)
        return eventLoop.future(view)
    }
}
