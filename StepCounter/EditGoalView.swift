import SwiftUI

struct EditGoalView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var stepCountState: StepCountState
    @State private var offset: Int = 0
    
    private var newGoal: Int {
        stepCountState.goal + offset
    }

    var body: some View {
        NavigationStack {
            VStack {
                dailyGoalHeader
                goalStepper
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save") {
                        save(newGoal)
                    }
                }
            }
        }
    }
}

extension EditGoalView {
    
    private var dailyGoalHeader: some View {
        Text("Daily Step Goal")
            .font(.system(size: 42))
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
                        .foregroundColor(.yellow)
                }
                .padding(.trailing)
                
                Text(String(newGoal))
                    .bold()
                Button {
                    offset += 1000
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.yellow)
                    
                }
                .padding(.leading)
            }
            .font(.system(size: 60))
            Text("STEPS / DAY")
        }
    }
    
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
