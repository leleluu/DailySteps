import SwiftUI

struct DayStepper: View {
        
    @Binding var numberOfDaysSinceToday: Int 
        
    private var date: Date {
        guard let unwrappedDate = Calendar.current.date(byAdding: .day, value: numberOfDaysSinceToday, to: Date.now) else {
            numberOfDaysSinceToday = 0
            return Date.now
        }
        return unwrappedDate
    }
    
    private var dateString: String {
        if numberOfDaysSinceToday == 0 {
            return "Today"
        } else if numberOfDaysSinceToday == -1 {
            return "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            decrementButton
            .padding(.trailing)
            Spacer()
            dateLabel
            Spacer()
            incrementButton
            .padding(.leading)
        }
    }
    
    // MARK: - Supplementary Views
    
    private var decrementButton: some View {
        Button {
            numberOfDaysSinceToday -= 1
        } label: {
            Image(systemName: "chevron.backward")
                .font(.system(size: 42))
                .tint(.darkGreen)

        }
    }
    private var dateLabel: some View {
        Text(dateString)
            .font(.system(size: 34, weight: .medium, design: .rounded)) 
            .foregroundColor(.darkGreen)
    }
    
    private var incrementButton: some View {
        Button {
            numberOfDaysSinceToday += 1
        } label: {
            Image(systemName: "chevron.forward")
                .font(.system(size: 42))
                .tint(.darkGreen)
        }
        .disabled(numberOfDaysSinceToday == 0)
    }
}

struct DayStepper_Previews: PreviewProvider {
    static var previews: some View {
        DayStepper(numberOfDaysSinceToday: .constant(20))
    }
}
