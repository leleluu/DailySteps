import SwiftUI

struct ProgressBox: View {
        
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
                .fill(.quaternary.opacity(0.5))
            VStack {
                HStack {
                    Text("\(percentage)% done")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Divider()
                        .padding()
                    Text("\(numberOfStepsLeft) steps to go")
                        .frame(maxWidth: .infinity, alignment: .center)

                }
                .fontDesign(.monospaced)
            }
        }
    }
}

struct ProgressBox_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBox(stepCount: 200, goal: 250)
    }
}
