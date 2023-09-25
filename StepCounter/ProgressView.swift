import SwiftUI

struct ProgressView: View {
        
    @ObservedObject var stepCountState: StepCountState

    var body: some View {
        ZStack {
            baseRing
            progressRing
            stepsLabel
        }
    }
}

extension ProgressView {
    
    private var baseRing: some View {
        Circle()
            .stroke(
                Color.gray.opacity(0.2),
                lineWidth: 36
            )
    }
    
    private var progressRing: some View {
        Circle()
            .trim(from: 0, to: stepCountState.progress)
            .stroke(
                Color.orange,
                style: StrokeStyle(
                    lineWidth: 40,
                    lineCap: .round
                )
            )
            .rotationEffect(Angle(degrees: -90))
            .animation(.easeOut, value: stepCountState.progress)

    }
    
    private var stepsLabel: some View {
        VStack {
            Text(String(stepCountState.stepCount))
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
            stepCountState: StepCountState())
    }
}
