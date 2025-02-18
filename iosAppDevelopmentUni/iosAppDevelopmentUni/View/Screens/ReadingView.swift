import SwiftUI

struct ReadingView: View {
    @Environment(\.presentationMode) var presentationMode
    let book: Book
    @State private var currentPage: Int
    @State private var dragOffset = CGSize.zero
    
    init(book: Book) {
        self.book = book
        _currentPage = State(initialValue: Int(book.pagesRead))
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
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
            
            Text("Swipe left or right to turn pages")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ReadingView(book: sampleBooks[1])
}
