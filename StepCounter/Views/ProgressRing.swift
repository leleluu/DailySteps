import SwiftUI

struct ProgressRing: View {
         
    let progress: Double 
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .center) {
                ZStack {
                    baseRing
                    progressRing
                    Image(systemName: "figure.walk")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }

    }
    
    // MARK: - Supplementary Views
    
    private var baseRing: some View {
        Circle()
            .stroke(
                Color.gray.opacity(0.2),
                lineWidth: 36
            )
    }
    
    private var progressRing: some View {
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
            .animation(.easeOut, value: progress)
    }
    
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing(
            progress: 0.3)
    }
}
