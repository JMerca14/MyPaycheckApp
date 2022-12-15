//
//  Confirmation_Page.swift
//  PaycheckApp
//
//  Created by Juan Mercado on 11/29/22.
//

import SwiftUI

struct Confirmation_Page: View {
    @EnvironmentObject var menuObject: MenuClass
    @State var newTotal = 0.0
    
    var moneyIn: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let total  = newTotal
        
        return formatter.string(from: NSNumber(value: total )) ?? "$0.00"
    }
    
    var body: some View {
        ZStack {
            Image("Background_V2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    HStack {
                        Button {
                            menuObject.isShowingAddMoney = false
                        } label: {
                            Image("Back_Icon")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(LinearGradient(colors: [CustomColors.PositiveTint,CustomColors.NegativeTint], startPoint: .leading, endPoint: .trailing))
                        }
                        
                        Spacer()
                            .frame(width: 20)
                        
                        Text("CONFIRMATION")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .black))
                    }
                }
                .offset(x: -25, y: 45)
                
                Spacer()
                
                VStack {
                    Text("\(moneyIn)")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 55, weight: .heavy))
                    
                    Text("Paycheck Amount Added")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .medium))
                }
                .offset(y: -175)
                
                Spacer()
                    .frame(height: 50)
                
                ZStack {
                    Rectangle()
                        .frame(width: 335, height: 400)
                        .foregroundStyle(LinearGradient(colors: [CustomColors.AccentTint,CustomColors.AccentBase], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 10)
                    
                    List {
                        if !menuObject.catArray.isEmpty {
                            ForEach(menuObject.catArray.sorted(by: >), id: \.key) { key, object in
                                HStack {
                                    Text("\(key)")
                                        .font(.system(size: 20, weight: .bold))
                                    Spacer()
                                    Divider()
                                        .frame(width: 1, height: 15)
                                        .overlay(CustomColors.AccentBase)
                                    Spacer()
                                    Text("\(object)%")
                                        .font(.system(size: 20, weight: .bold))
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                    Divider()
                                        .frame(width: 1, height: 15)
                                        .overlay(CustomColors.AccentBase)
                                    Spacer()
                                    Text(String(format: "$%.02f", (Double(object) / 100.0) * (Double(newTotal))))
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .medium))
                                }
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparatorTint(CustomColors.AccentShade)
                            .foregroundColor(.white)
                        }
                    }
                    .listStyle(.plain)
                    .frame(width: 335, height: 400)
                    .cornerRadius(10)
                    .background(.clear)
                    .scrollContentBackground(.hidden)
                }
                .offset(y: -50)
            }
        }
        .onAppear() {
            for v in menuObject.expenseArray {
                newTotal += v.value
            }
            
            newTotal = Double(menuObject.newMoney)! - (newTotal / 2)
        }
    }
}

struct Confirmation_Page_Previews: PreviewProvider {
    static var previews: some View {
        Confirmation_Page()
            .environmentObject(MenuClass())
    }
}
