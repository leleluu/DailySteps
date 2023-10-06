import SwiftUI

struct ProgressInfoBox: View {
        
    let stepCount: Int
    let goal: Int
    
    private var percentage: Int {
        Int(Double(stepCount) / Double(goal) * 100)
    }
    
    private var numberOfStepsLeft: Int {
        goal - stepCount
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.darkYellow)
            if percentage >= 100 {
                successMessage
            } else {
                percentageAndRemainingSteps

            }
        }
    }
    
    // MARK: - Supplementary Views
    
    private var percentageAndRemainingSteps: some View {
        HStack {
            Text("\(percentage)% done")
                .frame(maxWidth: .infinity, alignment: .center)
                .fontWeight(.semibold)
                .foregroundColor(.darkGreen)
            Divider()
                .frame(width: 1)
                .overlay(Color.darkGreen)
                .padding()
            Text("\(numberOfStepsLeft) steps left")
                .frame(maxWidth: .infinity, alignment: .center)
                .fontWeight(.semibold)
                .foregroundColor(.darkGreen)

        }
        .fontDesign(.monospaced)
    }
    
    private var successMessage: some View {
        Text("Well done! Daily step goal completed! ✅ ⭐️")
            .fontWeight(.semibold)
            .fontDesign(.monospaced)
            .frame(alignment: .center)
            .foregroundColor(.darkGreen)
            .padding()
        
    }
}

struct ProgressBox_Previews: PreviewProvider {
    static var previews: some View {
        ProgressInfoBox(stepCount: 200, goal: 250)
    }
}
