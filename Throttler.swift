class Example {
    let throttler = Throttler()
    
    func shortIntervalAction() {
        throttler.throttle {
            print("action!")
        }
    }
}

class Throttler: NSObject {
    private var task: DispatchWorkItem?
    
    func throttle(block: @escaping () -> Void) {
        task?.cancel()
        
        let task = DispatchWorkItem { block() }
        
        self.task = task
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: task)
    }
}
