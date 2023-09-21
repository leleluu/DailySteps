import SwiftUI

struct ProgressView: View {
        
    @Binding var stepCount: Int
    @Binding var progress: Double
    
    var body: some View {
        ZStack {
            baseRing
            progressRing
            stepsLabel
        }
    }
}

extension ProgressView {
    
    var baseRing: some View {
        Circle()
            .stroke(
                Color.gray.opacity(0.2),
                lineWidth: 36
            )
    }
    
    var progressRing: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(
                Color.orange,
                style: StrokeStyle(
                    lineWidth: 40,
                    lineCap: .round
                )
            )
            .rotationEffect(Angle(degrees: -90))
    }
    
    var stepsLabel: some View {
        VStack {
            Text(String(stepCount))
                .font(.system(size: 60))
                .bold()
            Text("steps")
                .font(.system(size: 26))
            
        }
    }
    
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(
            stepCount: .constant(1000), progress: .constant(0.5))
    }
}
