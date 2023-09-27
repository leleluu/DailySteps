import SwiftUI

struct StepCount: View {
        
    let stepCount: Int
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text(String(stepCount))
                .foregroundColor(.orange)
                .font(.system(size: 64, weight: .bold, design: .rounded))
            Text("STEPS")
                .font(.system(size: 26, design: .rounded))
        }
    }
}

struct StepCountLabel_Previews: PreviewProvider {
    static var previews: some View {
        StepCount(stepCount: 300)
    }
}
