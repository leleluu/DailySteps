import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var stepCount: Int = 0
        
    private var healthKitManager = HealthHitManager()

    var body: some View {
        VStack {
            Text(String(stepCount))
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
