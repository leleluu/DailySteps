import SwiftUI

struct ProgressRing: View {
         
    let progress: Double
    let progressCircleLineWidth: CGFloat = 40
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                baseRing
                progressRing
                Image(systemName: progress >= 1 ? "trophy.fill": "figure.run")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: geometry.size.width / 3,
                        height: geometry.size.width / 3
                    )
                    .foregroundColor(.darkGreen)
            }
            .padding(progressCircleLineWidth / 2)
            .position(
                x: geometry.size.width / 2,
                y: geometry.size.height / 2
            )
        }
    }
    
    // MARK: - Supplementary Views
    
    private var baseRing: some View {
        Circle()
            .stroke(
                Color.gray.opacity(0.2),
                lineWidth: progressCircleLineWidth - 3
            )
    }
    
    private var progressRing: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(
                Color.lightOrange,
                style: StrokeStyle(
                    lineWidth: progressCircleLineWidth,
                    lineCap: .round
                )
            )
            .rotationEffect(Angle(degrees: -90))
            .animation(.easeOut(duration: 1), value: progress)
    }
    
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing(
            progress: 0.3)
    }
}
