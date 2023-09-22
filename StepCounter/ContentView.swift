import SwiftUI

struct ContentView: View {
    
    @State private var stepCount: Int = 0
    @State private var progress: Double = 0.0
    @State private var numberOfDaysSinceToday = 0

    private let healthKitManager = HealthKitManager()
    
    private var date: Date {
        guard let unwrappedDate = Calendar.current.date(byAdding: .day, value: numberOfDaysSinceToday, to: Date.now) else {
            numberOfDaysSinceToday = 0
            return Date.now
        }
        return unwrappedDate
    }
    
    private var dateString: String {
        if numberOfDaysSinceToday == 0 {
            return "Today"
        } else if numberOfDaysSinceToday == -1 {
            return "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .full 
            return formatter.string(from: date)
        }
    }
    
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
            getStepCount(for: date)
        }
    }
}

extension ContentView {
        
    private var dayStepper: some View {
        HStack {
            Button {
                numberOfDaysSinceToday -= 1
                getStepCount(for: date)
            } label: {
                Image(systemName: "chevron.backward")
            }
            .padding(.trailing)
            Text(dateString)
            Button {
                if numberOfDaysSinceToday < 0 {
                    numberOfDaysSinceToday += 1
                }
                getStepCount(for: date)
            } label: {
                Image(systemName: "chevron.forward")
            }
            .padding(.leading)
        }
    }
    
    private func getStepCount(for date: Date) {
        healthKitManager.requestAuthorization { (success, _) in
            if success {
                healthKitManager.getStepCount(for: date) { steps, error in
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
