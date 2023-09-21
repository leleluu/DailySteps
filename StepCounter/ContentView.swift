import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @State private var stepCount: Int = 0
    @State private var progress: Double = 0.0
    
    private var healthKitManager = HealthHitManager()
    private let dummyGoal: Int = 10000

    var body: some View {
        VStack {
            ProgressView(
                stepCount: $stepCount,
                progress: $progress
            )
        }
        .padding()
        .onAppear {
            getStepCount()
        }
    }
    
    // MARK: - Methods
    
    private func getStepCount() {
        healthKitManager.requestAuthorization { (success, _) in
            if success {
                healthKitManager.getStepCount { steps, error in
                    DispatchQueue.main.async {
                        stepCount = Int(steps)
                        progress = steps / Double(dummyGoal)
                    }
                }
            } else {
                // handle error
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
