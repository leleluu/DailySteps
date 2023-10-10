import SwiftUI

struct EditGoalView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var stepCountState: StepCountState
    @State private var offset: Int = 0
    
    private var newGoal: Int {
        stepCountState.goal + offset
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.lightYellow
                    .ignoresSafeArea(.all)
                VStack {
                    dailyGoalHeader
                    goalStepper
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                    .tint(.darkGreen)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save") {
                        save(newGoal)
                    }
                    .tint(.darkGreen)
                    .disabled(newGoal == 0)
                }
            }
        }
    }
    
    // MARK: - Supplementary Views
    
    private var dailyGoalHeader: some View {
        Text("Daily Step Goal")
            .font(.system(size: 42))
            .foregroundColor(.darkGreen)
            .bold()
            .padding()
    }
    
    private var goalStepper: some View {
        VStack {
            HStack {
                Button {
                    offset -= 1000
                } label: {
                    Image(systemName: "minus.circle")
                        .tint(.lightOrange)
                }
                .disabled(newGoal == 0)
                .padding(.leading)
                Spacer()  
                Text(String(newGoal))
                    .foregroundColor(.darkGreen)
                    .bold()
                Spacer()
                Button {
                    offset += 1000
                } label: {
                    Image(systemName: "plus.circle")
                        .tint(.lightOrange)
                    
                }
                .padding(.trailing)
            }
            .font(.system(size: 60))
            Text("STEPS / DAY")
                .foregroundColor(.darkGreen) 
        }
    }
    
    // MARK: - Methods
    
    private func save(_ newGoal: Int) {
        stepCountState.setGoal(to: newGoal)
        offset = 0 // reset offset to avoid incorrect goal being displayed briefly just as sheet is dismissing
        dismiss()
    }
}

struct AddGoalView_Previews: PreviewProvider {
    static var previews: some View {
        EditGoalView(stepCountState: StepCountState())
    }
}
