import SwiftUI

let primaryGreen = Color(red: 0, green: 0.53, blue: 0.01)
let secondaryGreen = Color(red:0.36, green:0.70, blue:0.19)

struct ContentView: View {
    @State private var selectedCard: String = "Card 1"
    @State private var showPickerSheet: Bool = false
    @State private var cards: [String] = ["Card 1", "Card 2", "Card 3"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Image("card")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.35), radius: 10, x: 0, y: 2)
                        .padding(.top, 16) // ナビゲーションバーの下にスペースを追加
                    
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text("Balance")
                            Text("¥15,834")
                                .font(.title)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        Button(action: {}) {
                            Text("Add Money")
                                .padding([.leading, .trailing], 18)
                                .padding([.top, .bottom], 12)
                                .foregroundColor(.white)
                                .background(primaryGreen)
                                .cornerRadius(99)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
                    
                    ZStack{
                        Color(UIColor.systemBackground)
                        VStack (spacing:16){
                            ProductCard(icon: "plus.rectangle", title: "チケット購入", text:"グリーン車や新幹線チケットの購入")
                            Divider()
                            ProductCard(icon: "clock", title: "利用履歴", text:"利用履歴の確認")
                            Divider()
                            ProductCard(icon: "gear", title: "カード設定", text:"Suicaの各種設定")
                        }
                        .padding([.leading, .top, .bottom],16)
                    }
                    .cornerRadius(10)
                }
                .padding(16)
            }
            .navigationTitle(selectedCard)
//            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "person.circle")
                            .imageScale(.large)
                            .foregroundStyle(primaryGreen)
                    }
                }
                ToolbarItem {
                    Button(action: {
                        showPickerSheet.toggle()
                    }) {
                        Text("Other Cards")
                            .foregroundStyle(primaryGreen)
                    }
                }
            }
            .background(Color(UIColor.secondarySystemBackground))
            .sheet(isPresented: $showPickerSheet) {
                CardPickerSheet(selectedCard: $selectedCard, cards: $cards)
//                    .background(Color.black.opacity(0.5))
            }
        }
    }
}

struct CardPickerSheet: View {
    @Binding var selectedCard: String
    @Binding var cards: [String]
    @State private var newCardName: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Your Suica", selection: $selectedCard) {
                    ForEach(cards, id: \.self) {
                        card in Text(card).tag(card)
                    }
                }
                .pickerStyle(.inline)
            }
            .navigationTitle("Select Card")
            .navigationBarItems(leading: Button("Add") {
            }, trailing: Button("Done") {
                dismiss()
            }.bold())
        }
    }
}

#Preview {
    ContentView()
}

struct ProductCard: View {
    var icon: String
    var title: String
    var text: String
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack {
                secondaryGreen
                Image(systemName: icon)
                    .foregroundStyle(.white)
                    .font(.title2)
            }
            .frame(width: 48, height: 48)
            .cornerRadius(8)
            VStack(alignment: .leading){
                Text(title)
                    .foregroundStyle(primaryGreen)
                    .font(.headline)
//                Text(text)
//                    .font(.caption)
            }
            .padding(.leading, 4)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
//        .padding([.top, .trailing, .bottom], 16)
        .padding(.trailing, 16)
        .frame(maxWidth: .infinity, alignment: .center)
//        .background(Color(UIColor.systemBackground))
    }
}
