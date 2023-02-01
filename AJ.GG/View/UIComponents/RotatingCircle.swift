import SwiftUI

struct RotatingCircle: View {
    @State private var rotation: Double = 0
        
        var body: some View {
            Circle()
                .trim(from: 0, to: 0.9)
                .stroke(Color.blue, lineWidth: 4)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(rotation))
                .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: rotation)
                .onAppear() {
                    self.rotation = 360
                }
        }
}

struct RotatingCircle_Previews: PreviewProvider {
    static var previews: some View {
        RotatingCircle()
    }
}
