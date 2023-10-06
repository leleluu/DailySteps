import SwiftUI

extension View {
    
    func animatingOverlay(for number: Int) -> some View {
        modifier(AnimatableNumberModifier(number: number))
    }
}
