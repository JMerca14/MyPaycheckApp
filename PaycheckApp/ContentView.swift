// - MARK: Imports
import SwiftUI

// - MARK: Structs
struct CustomColors {
    // - MARK: Accents
    static let AccentBase = Color("Accent_Base")
    static let AccentTint = Color("Accent_Tint")
    static let AccentShade = Color("Accent_Shade")
    
    // - MARK: Positives
    static let PositiveBase = Color("Positive_Base")
    static let PositiveTint = Color("Positive_Tint")
    static let PositiveShade = Color("Positive_Shade")
    
    // - MARK: Negatives
    static let NegativeBase = Color("Negative_Base")
    static let NegativeTint = Color("Negative_Tint")
    static let NegativeShade = Color("Negative_Shade")
    
    // - MARK: Warnings
    static let WarningBase = Color("Warning_Base")
    static let WarningTint = Color("Warning_Tint")
    static let WarningShade = Color("Warning_Shade")
}

// - MARK: Classes
class MenuClass : ObservableObject {
    @Published var catArray = UserDefaults.standard.object(forKey: "CategoryArray") as? [String: Int] ?? [:]
    @Published var expenseArray = UserDefaults.standard.object(forKey: "ExpenseArray") as? [String: Double] ?? [:]
    
    @Published var PopUpSize = ["width": CGFloat(385), "height": CGFloat(200), "x": CGFloat(0.0), "y": 610.0, "AnimWidth": CGFloat(385), "AnimHeight": CGFloat(325)]
    @Published var newMoney = ""
    
    @Published var objOpacity = 0.0
    @Published var objActive = false
    @Published var isCategory = false
    
    @Published var addObjPos = ["x": CGFloat(0.0), "y": CGFloat(0.0)]
    @Published var stackPos = ["x": CGFloat(0.0), "y": CGFloat(50.0)]
    @Published var goalsStackPos = ["x": CGFloat(400.0), "y": CGFloat(0.0)]
    @Published var progressStackPos = ["x": CGFloat(-400.0), "y": CGFloat(0.0)]
    
    @Published var Percentage = 100
    @Published var DollarAmmount = 0.0
    
    @Published var isShowingAddMoney = false
    @Published var isSideMenuActive = false
    @Published var isGoalsPageActive = false
    @Published var isProgressPageActive = false
    
    @Published var homeButtonColor = CustomColors.PositiveTint
    @Published var goalsButtonColor = Color.white
    @Published var progressButtonColor = Color.white
}

// - MARK: Content View
struct ContentView: View {
    // - MARK: Observable Objects
    @ObservedObject var menuObject = MenuClass()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background_V1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(0)
                
                ZStack {
                    Home_Page()
                        .offset(x: menuObject.stackPos["x"]!, y: menuObject.stackPos["y"]!)
                        .animation(.easeInOut(duration: 0.5), value: menuObject.stackPos)
                    Goals_Page()
                        .offset(x: menuObject.progressStackPos["x"]!, y: menuObject.progressStackPos["y"]!)
                        //.animation(.easeInOut(duration: 0.5), value: menuObject.progressStackPos)
                    Goals_Page() // Goals
                        .offset(x: menuObject.goalsStackPos["x"]!, y: menuObject.goalsStackPos["y"]!)
                        //.animation(.easeInOut(duration: 0.5), value: menuObject.goalsStackPos)
                }
                
                ZStack {
                    Rectangle()
                        .fill(LinearGradient(colors: [CustomColors.AccentBase, CustomColors.AccentShade], startPoint: .leading, endPoint: .trailing))
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .infinity, maxHeight: 75)
                        .cornerRadius(5)
                    
                    HStack {
                        Button {
                            menuObject.isGoalsPageActive = false
                            menuObject.isProgressPageActive = true
                            menuObject.homeButtonColor = Color.white
                            menuObject.goalsButtonColor = Color.white
                            menuObject.progressButtonColor = CustomColors.PositiveTint
                            menuObject.goalsStackPos["x"] = menuObject.isGoalsPageActive ? 0 : 400
                            menuObject.goalsStackPos["y"] = menuObject.isGoalsPageActive ? 0 : 0
                            menuObject.progressStackPos["x"] = menuObject.isProgressPageActive ? 0 : -400
                            menuObject.progressStackPos["y"] = menuObject.isProgressPageActive ? 0 : 0
                        } label: {
                            Image("Progress_Icon")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(menuObject.progressButtonColor)
                        }
                        .animation(.easeInOut(duration: 0.2), value: menuObject.progressButtonColor)
                        
                        Spacer()
                            .frame(width: 85)
                        
                        Button {
                            menuObject.isGoalsPageActive = false
                            menuObject.isProgressPageActive = false
                            menuObject.homeButtonColor = CustomColors.PositiveTint
                            menuObject.goalsButtonColor = Color.white
                            menuObject.progressButtonColor = Color.white
                            menuObject.goalsStackPos["x"] = menuObject.isGoalsPageActive ? 0 : 400
                            menuObject.goalsStackPos["y"] = menuObject.isGoalsPageActive ? 0 : 0
                            menuObject.progressStackPos["x"] = menuObject.isProgressPageActive ? 0 : -400
                            menuObject.progressStackPos["y"] = menuObject.isProgressPageActive ? 0 : 0
                        } label: {
                            Image("Home_Icon")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .foregroundColor(menuObject.homeButtonColor)
                        }
                        .animation(.easeInOut(duration: 0.2), value: menuObject.homeButtonColor)
                        
                        Spacer()
                            .frame(width: 85)
                        
                        Button {
                            menuObject.isProgressPageActive = false
                            menuObject.isGoalsPageActive = true
                            menuObject.homeButtonColor = Color.white
                            menuObject.progressButtonColor = Color.white
                            menuObject.goalsButtonColor = CustomColors.PositiveTint
                            menuObject.progressStackPos["x"] = menuObject.isProgressPageActive ? 0 : -400
                            menuObject.progressStackPos["y"] = menuObject.isProgressPageActive ? 0 : 0
                            menuObject.goalsStackPos["x"] = menuObject.isGoalsPageActive ? 0 : 400
                            menuObject.goalsStackPos["y"] = menuObject.isGoalsPageActive ? 0 : 0
                        } label: {
                            Image("Goals_Icon")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(menuObject.goalsButtonColor)
                        }
                        .animation(.easeInOut(duration: 0.2), value: menuObject.goalsButtonColor)
                    }
                    .offset(y: -8)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(Color.black)
                    .opacity(menuObject.objOpacity)
                    .animation(.easeInOut(duration: 0.5), value: menuObject.objOpacity)
                
                ZStack {
                    PopUpView()
                        .offset(y: menuObject.PopUpSize["y"]!)
                        .animation(.easeInOut(duration: 0.5), value: menuObject.PopUpSize["y"]!)
                }
            }
        }
        .onAppear() {
            for (_,value) in menuObject.catArray {
                menuObject.Percentage -= value
            }
        }
        .environmentObject(menuObject)
    }
}

// - MARK: Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MenuClass())
    }
}
