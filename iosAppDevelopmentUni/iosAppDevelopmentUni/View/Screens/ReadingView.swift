import SwiftUI

struct ReadingView: View {
    @Environment(\.presentationMode) var presentationMode
    let book: Book
    @State private var currentPage: Int
    @State private var dragOffset = CGSize.zero
    private let dataController = BookDataController.shared
    @Environment(\.dismiss) private var dismiss
    var onDismiss: (() -> Void)?

    init(book: Book, onDismiss: (() -> Void)? = nil) {
        self.book = book
        self.onDismiss = onDismiss
        _currentPage = State(initialValue: max(1, min(book.pagesRead, book.totalPages)))
    }
    
    private func updateBookProgress() {
        book.pagesRead = currentPage
        dataController.saveContext()
        onDismiss?()
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    updateBookProgress()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding()
                }
                Spacer()
                Text("Page \(currentPage) of \(book.totalPages)")
                    .foregroundColor(.gray)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "gear")
                        .opacity(0.0)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            
            Spacer()
            
            Text("Reading \(book.title)")
                .font(.title2)
                .padding(.bottom)
            
            Text("This is a simulated page \(currentPage) of the book.")
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .rotation3DEffect(
                    .degrees(-Double(dragOffset.width) / 5),
                    axis: (x: 0, y: 1, z: 0)
                )
                .offset(x: dragOffset.width)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            dragOffset = gesture.translation
                        }
                        .onEnded { gesture in
                            let threshold: CGFloat = 50
                            if gesture.translation.width < -threshold && currentPage < Int(book.totalPages) {
                                withAnimation(.spring()) {
                                    currentPage += 1
                                    dragOffset = .zero
                                }
                            } else if gesture.translation.width > threshold && currentPage > 1 {
                                withAnimation(.spring()) {
                                    currentPage -= 1
                                    dragOffset = .zero
                                }
                            } else {
                                withAnimation(.spring()) {
                                    dragOffset = .zero
                                }
                            }
                        }
                )
            
            Spacer()

            Text("\(Int(book.getProgressPercentage()))% Complete")
                    .font(.caption)
                    .foregroundColor(.gray)
            
            Text("Swipe left or right to turn pages")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
        }
        .navigationBarHidden(true)
        .onDisappear {
            updateBookProgress()
        }
    }
}

#Preview {
    ReadingView(book: sampleBooks[1])
}
