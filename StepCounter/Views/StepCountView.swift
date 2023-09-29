import SwiftUI

struct StepCountView: View {

    let stepCount: Int
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Color.clear
                .frame(height: 60)
                .animatingOverlay(for: stepCount)
                .animation(.easeInOut(duration: 1), value: stepCount)
            Text("STEPS")
                .font(.system(size: 26, design: .rounded))
        }
    }
}

struct StepCountLabel_Previews: PreviewProvider {
    static var previews: some View {
        StepCountView(stepCount: 300)
    }
}



