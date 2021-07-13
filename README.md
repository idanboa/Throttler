# Throttler
Simple swift throttling

Insperation taken from https://mobikul.com/throttling-calls-for-searching-in-swift/

``` swift
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
```
