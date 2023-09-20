import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
        
    private var healthKitManager = HealthHitManager()

    var body: some View {
        VStack {
            Text("Hello, world!")
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
                // get step count
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
