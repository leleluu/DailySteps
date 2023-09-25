import SwiftUI

struct ContentView: View {
    
    @StateObject private var stepCountState = StepCountState()
    
    @State private var numberOfDaysSinceToday = 0
    @State private var isShowingAddGoalView = true
        
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
    
    var body: some View {
        NavigationStack {
            VStack {
                dayStepper
                .padding()
                ProgressView(stepCountState: stepCountState)
                .padding()
                Text("Daily Step Goal: \(stepCountState.goal)")
            }
            .padding()
            .onAppear {
                getStepCount(for: date)
            }
            .sheet(isPresented: $isShowingAddGoalView) {
                EditGoalView(stepCountState: stepCountState) 
            }
            .navigationTitle("Title")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddGoalView =  true
                    } label: {
                        Image(systemName: "trophy.fill")
                            .resizable()
                            .foregroundColor(.yellow)
                    }
                }
            }
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
        stepCountState.updateStepCount(for: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
