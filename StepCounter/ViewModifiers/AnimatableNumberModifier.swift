import SwiftUI

// Using rolling number animation from: https://stefanblos.com/posts/animating-number-changes/

struct AnimatableNumberModifier: AnimatableModifier {
    var animatableData: Double
    
    init(number: Int) {
        animatableData = Double(number)
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Text("\(Int(animatableData))")
                    .foregroundColor(.lightOrange)
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                    .monospacedDigit()
            )
    }
}
