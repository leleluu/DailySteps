import SwiftUI

struct ContentView: View {
    
    @State private var stepCount: Int = 0
    @State private var progress: Double = 0.0
    @State private var numberOfDaysSinceToday = 0

    private let healthKitManager = HealthKitManager()
    private let dummyGoal: Int = 10000

    var body: some View {
        VStack {
            dayStepper
            .padding()
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
}

extension ContentView {
        
    private var dayStepper: some View {
        HStack {
            Button {
                numberOfDaysSinceToday -= 1
                getStepCount()
            } label: {
                Image(systemName: "chevron.backward")
            }
            Text("Today")
            Button {
                if numberOfDaysSinceToday < 0 {
                    numberOfDaysSinceToday += 1 
                }
                getStepCount()
            } label: {
                Image(systemName: "chevron.forward")
            }
        }
    }
    
    private func getStepCount() {
        healthKitManager.requestAuthorization { (success, _) in
            if success {
                healthKitManager.getStepCount(for: numberOfDaysSinceToday) { steps, error in
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
