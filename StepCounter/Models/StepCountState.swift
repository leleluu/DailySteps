import Foundation

class StepCountState: ObservableObject {
    
    @Published private(set) var goal: Int = 8000
    @Published private(set) var stepCount: Int = 0
    @Published private(set) var progress: Double = 0.0
    
    private let healthKitManager = HealthKitManager()

    func setGoal(to newGoal: Int) {
        goal = newGoal
        progress = Double(stepCount) / Double(goal)
    }
    
    func updateStepCount(for date: Date) {
        healthKitManager.requestAuthorization { [weak self] (success, _) in
            if success {
                self?.healthKitManager.getStepCount(for: date) { [weak self] steps, error in
                    guard let self else { return }
                    DispatchQueue.main.async {
                        self.stepCount = Int(steps)
                        self.progress = steps / Double(self.goal)
                    }
                }
            } else {
                /*
                Usually the error would be passed back to the view so that this
                information can be presented to the user. However, I decided against
                implementing any kind of error handling in this project as I wanted to focus
                on basic SwiftUI and data flow.
                */
            }
        }

    }
    
    
}
