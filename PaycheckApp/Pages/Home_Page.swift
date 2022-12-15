//
//  Home_Page.swift
//  PaycheckApp
//
//  Created by Juan Mercado on 12/5/22.
//

import SwiftUI

struct Home_Page: View {
    @EnvironmentObject var menuObject: MenuClass
    
    // - MARK: Variables
    @FocusState var isFocused: Bool
    var testNum = 0.0
    
    var moneyIn: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let total  = testNum
        
        return formatter.string(from: NSNumber(value: total )) ?? "$0.00"
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button {
                        menuObject.isSideMenuActive = !menuObject.isSideMenuActive
                        menuObject.stackPos["x"] = menuObject.isSideMenuActive ? 125 : 0
                        menuObject.stackPos["y"] = menuObject.isSideMenuActive ? 125 : 50
                    } label: {
                        Image("Dash_Icon")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                    Spacer()
                        .frame(width: 20)
                    
                    Text("MY PAYCHECK")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .black))
                }
            }
            .offset(x: -25, y: -5)
            
            Spacer()
                .frame(height: 10)
            
            ScrollView {
                ZStack {
                    Rectangle()
                        .background(.ultraThinMaterial)
                        .foregroundColor(CustomColors.AccentBase.opacity(0.8))
                        .foregroundStyle(.ultraThinMaterial)
                        .cornerRadius(10)
                        .frame(width: 335, height: 198)
                        .shadow(radius: 5)
                    
                    VStack {
                        HStack {
                            Text("CATEGORIES")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)
                            //.offset(x: -60, y: 10)
                            
                            Spacer()
                                .frame(width: 98)
                            
                            Button {
                                menuObject.isCategory = true
                                menuObject.objActive.toggle()
                                menuObject.PopUpSize["y"]! = menuObject.objActive ? menuObject.PopUpSize["AnimHeight"]! : 610.0
                                menuObject.objOpacity = menuObject.objActive ? 0.8 : 0.0
                            } label: {
                                Image("Plus_Icon")
                                    .resizable()
                                    .foregroundStyle(LinearGradient(colors: [CustomColors.PositiveTint,CustomColors.NegativeTint], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: 25, height: 25)
                            }
                        }
                        .offset(y: 10)
                        
                        List {
                            if !menuObject.catArray.isEmpty {
                                ForEach(menuObject.catArray.sorted(by: >), id: \.key) { key, object in
                                    HStack {
                                        Text("\(key):")
                                            .font(.system(size: 20, weight: .bold))
                                        Spacer()
                                        Stepper("\(object)%", onIncrement: {
                                            if menuObject.Percentage > 0 {
                                                menuObject.catArray[key]! = menuObject.catArray[key]! + 1
                                                menuObject.Percentage -= 1
                                                UserDefaults.standard.set(menuObject.catArray, forKey: "CategoryArray")
                                            }
                                        }, onDecrement: {
                                            if menuObject.Percentage < 100 {
                                                menuObject.catArray[key]! = menuObject.catArray[key]! - 1
                                                menuObject.Percentage += 1
                                                UserDefaults.standard.set(menuObject.catArray, forKey: "CategoryArray")
                                            }
                                        })
                                    }
                                }
                                .onDelete(perform: Delete)
                                .listRowBackground(Color.clear)
                                .listRowSeparatorTint(CustomColors.AccentShade)
                                .foregroundColor(.white)
                            }
                        }
                        .listStyle(.plain)
                        .frame(width: 300)
                        .cornerRadius(10)
                        .background(.clear)
                        .scrollContentBackground(.hidden)
                        .offset(x: -10)
                    }
                }
                
                Spacer()
                    .frame(height: 10)
                
                ZStack {
                    Rectangle()
                        .background(.ultraThinMaterial)
                        .foregroundColor(CustomColors.AccentBase.opacity(0.8))
                        .foregroundStyle(.ultraThinMaterial)
                        .cornerRadius(10)
                        .frame(width: 335, height: 198)
                        .shadow(radius: 5)
                    
                    VStack {
                        HStack {
                            Text("EXPENSES")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)
                            //.offset(x: -60, y: 10)
                            
                            Spacer()
                                .frame(width: 98)
                            
                            Button {
                                menuObject.isCategory = false
                                menuObject.objActive.toggle()
                                menuObject.PopUpSize["y"]! = menuObject.objActive ? menuObject.PopUpSize["AnimHeight"]! : 610.0
                                menuObject.objOpacity = menuObject.objActive ? 0.8 : 0.0
                            } label: {
                                Image("Plus_Icon")
                                    .resizable()
                                    .foregroundStyle(LinearGradient(colors: [CustomColors.PositiveTint,CustomColors.NegativeTint], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: 25, height: 25)
                            }
                        }
                        .offset(y: 10)
                        
                        List {
                            if !menuObject.expenseArray.isEmpty {
                                ForEach(menuObject.expenseArray.sorted(by: >), id: \.key) { key, object in
                                    HStack {
                                        Text("\(key):")
                                            .font(.system(size: 20, weight: .bold))
                                        Spacer()
                                        Stepper("$" + String(format: "%.0f", object), onIncrement: {
                                            menuObject.expenseArray[key]! = menuObject.expenseArray[key]! + 1
                                            UserDefaults.standard.set(menuObject.expenseArray, forKey: "ExpenseArray")
                                        }, onDecrement: {
                                            if object > 0 {
                                                menuObject.expenseArray[key]! = menuObject.expenseArray[key]! - 1
                                                UserDefaults.standard.set(menuObject.expenseArray, forKey: "ExpenseArray")
                                            }
                                        })
                                    }
                                }
                                .onDelete(perform: DeleteExpense)
                                .listRowBackground(Color.clear)
                                .listRowSeparatorTint(CustomColors.AccentShade)
                                .foregroundColor(.white)
                            }
                        }
                        .listStyle(.plain)
                        .frame(width: 300)
                        .cornerRadius(10)
                        .background(.clear)
                        .scrollContentBackground(.hidden)
                        .offset(x: -10)
                    }
                }
                
                Spacer()
                    .frame(height: 10)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .background(.ultraThinMaterial)
                            .foregroundColor(CustomColors.AccentBase.opacity(0.8))
                            .foregroundStyle(.ultraThinMaterial)
                            .cornerRadius(10)
                            .frame(width: 162, height: 243)
                            .shadow(radius: 5)
                    }
                    
                    ZStack {
                        Rectangle()
                            .background(.ultraThinMaterial)
                            .foregroundColor(CustomColors.AccentBase.opacity(0.8))
                            .foregroundStyle(.ultraThinMaterial)
                            .cornerRadius(10)
                            .frame(width: 162, height: 243)
                            .shadow(radius: 5)
                        
                        VStack {
                            Text("ADD MONEY")
                                .font(.system(size: 20, weight: .heavy))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .offset(x: -8)
                            
                            Text("Add a Paycheck")
                                .font(.system(size: 15, weight: .light))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .offset(x: -13)
                            
                            Spacer()
                                .frame(height: 20)
                            
                            TextField("Enter Amount", text: $menuObject.newMoney)
                                .frame(width: 114, height: 25, alignment: .center)
                                .multilineTextAlignment(.center)
                                .background(CustomColors.PositiveTint.opacity(0.35))
                                .cornerRadius(50)
                                .foregroundColor(.white)
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                                .onChange(of: isFocused, perform: { newValue in
                                    if newValue {
                                        menuObject.addObjPos["x"] = -75.0
                                        menuObject.addObjPos["y"] = -100
                                        menuObject.newMoney = ""
                                    }
                                })
                            
                            Spacer()
                                .frame(height: 20)
                            
                            ZStack {
                                Ellipse()
                                    .fill(CustomColors.AccentShade)
                                
                                Ellipse()
                                    .strokeBorder(LinearGradient(colors: [CustomColors.PositiveTint,CustomColors.NegativeTint], startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                                
                                NavigationLink(destination: Confirmation_Page().navigationBarBackButtonHidden(true), isActive: $menuObject.isShowingAddMoney) {
                                    Image("Plus_Icon")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 50, height: 50)
                                }.simultaneousGesture(TapGesture().onEnded{
                                    isFocused = false
                                    menuObject.addObjPos["x"] = 0
                                    menuObject.addObjPos["y"] = 0
                                    
                                    if menuObject.newMoney.isEmpty {
                                        menuObject.isShowingAddMoney = false
                                    }
                                })
                            }
                            .frame(width: 102, height: 102)
                            
                        }
                    }
                    .offset(x: menuObject.addObjPos["x"]!, y: menuObject.addObjPos["y"]!)
                    .animation(.easeInOut(duration: 0.5), value: menuObject.addObjPos)
                }
            }
        }
    }
    
    func Delete(at offsets: IndexSet) {
        if let ndx = offsets.first {
            let item = menuObject.catArray.sorted(by: >)[ndx]
            menuObject.catArray.removeValue(forKey: item.key)
            UserDefaults.standard.set(menuObject.catArray, forKey: "CategoryArray")
            menuObject.Percentage = 100
            
            for (_,value) in menuObject.catArray {
                menuObject.Percentage -= value
            }
        }
    }
    
    func DeleteExpense(at offsets: IndexSet) {
        if let ndx = offsets.first {
            let item = menuObject.expenseArray.sorted(by: >)[ndx]
            menuObject.expenseArray.removeValue(forKey: item.key)
            UserDefaults.standard.set(menuObject.expenseArray, forKey: "ExpenseArray")
        }
    }
}

struct Home_Page_Previews: PreviewProvider {
    static var previews: some View {
        Home_Page()
            .environmentObject(MenuClass())
    }
}
