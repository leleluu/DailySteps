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
        GeometryReader { geometry in
            VStack {
                DayStepper(numberOfDaysSinceToday: $numberOfDaysSinceToday)
                    .padding(EdgeInsets(
                        top: 16,
                        leading: 8,
                        bottom: 16,
                        trailing: 8
                    ))
                Spacer()
                ProgressRing(progress: stepCountState.progress)
                    .frame(height: geometry.size.height * 0.4)
                StepCountView(stepCount: stepCountState.stepCount)
                    .frame(height: geometry.size.height * 0.2)
                Spacer()

                dailyGoalSection
                ProgressInfoBox(stepCount: stepCountState.stepCount, goal: stepCountState.goal)
                    .frame(height: geometry.size.height * 0.15)
                    .onChange(of: numberOfDaysSinceToday) { _ in
                          getStepCount(for: date)
                    }
                    .padding(.bottom, 16)
            }
            .onAppear {
                getStepCount(for: date)
            }
            .sheet(isPresented: $isShowingAddGoalView) {
                EditGoalView(stepCountState: stepCountState)
            }
        }
        .padding()
        .background(Color.paleYellow)
    }
    
    // MARK: - Supplementary Views
    
    private var dailyGoalSection: some View {
        HStack {
            Text("Daily Goal: \(stepCountState.goal)")
                .font(.system(size: 22, weight: .semibold, design: .monospaced)) 
                .foregroundColor(.lightPink)
            Button {
                isShowingAddGoalView =  true
            } label: {
                Image(systemName: "pencil")
                    .tint(.lightPink)
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
