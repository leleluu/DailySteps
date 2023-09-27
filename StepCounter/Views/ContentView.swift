import SwiftUI

struct ContentView: View {
        
    @StateObject private var stepCountState = StepCountState()
    @State private var numberOfDaysSinceToday = 0
    @State private var isShowingAddGoalView = false
    
    private var date: Date {
        guard let unwrappedDate = Calendar.current.date(byAdding: .day, value: numberOfDaysSinceToday, to: Date.now) else {
            numberOfDaysSinceToday = 0
            return Date.now
        }
        return unwrappedDate
    }

    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color.clear
                        .ignoresSafeArea(.all)
                    VStack {
                        DayStepper(numberOfDaysSinceToday: $numberOfDaysSinceToday)
                        ProgressRing(progress: stepCountState.progress)
                            .frame(height: geometry.size.height * 0.3)
                        
                        StepCount(stepCount: stepCountState.stepCount
                        )
                        dailyGoalSection
                        ProgressBox(stepCount: stepCountState.stepCount, goal: stepCountState.goal)
                            .frame(height: geometry.size.height * 0.1)
                            .onChange(of: numberOfDaysSinceToday) { _ in
                                  getStepCount(for: date)
                            }
                    }
                    .onAppear {
                        getStepCount(for: date)
                    }
                    .sheet(isPresented: $isShowingAddGoalView) {
                        EditGoalView(stepCountState: stepCountState)
                    }
                }
                .padding()
            }
        }
    }
    
    // MARK: - Supplementary Views
    
    private var dailyGoalSection: some View {
        HStack {
            Text("Daily Goal: \(stepCountState.goal)")
                .fontDesign(.monospaced)
            Button {
                isShowingAddGoalView =  true
            } label: {
                Image(systemName: "pencil")
                    .foregroundColor(.yellow)
            }
        }
    }
    
    // MARK: - Methods
    
    private func getStepCount(for date: Date) {
        stepCountState.updateStepCount(for: date)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
