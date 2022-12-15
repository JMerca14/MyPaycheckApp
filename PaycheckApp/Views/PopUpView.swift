//
//  PopUpView.swift
//  PaycheckApp
//
//  Created by Juan Mercado on 11/13/22.
//

import SwiftUI

struct PopUpView: View {
    @EnvironmentObject var menuObject: MenuClass
    @State var newCategory = ""
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: menuObject.PopUpSize["width"], height: menuObject.PopUpSize["height"])
                .cornerRadius(30)
                .foregroundColor(CustomColors.AccentTint)
            
            VStack {
                Text("ADD CATEGORY")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .heavy))
                    //.offset(x: -20)
                Text("Enter Category Name Below")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .medium))
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    TextField("Category Name", text: $newCategory)
                        .frame(width: 250, height: 50, alignment: .center)
                        .multilineTextAlignment(.center)
                        .background(CustomColors.AccentShade.opacity(0.35))
                        .cornerRadius(50)
                        .foregroundColor(.white)
                        .keyboardType(.default)
                        .focused($isFocused)
                        .onChange(of: isFocused, perform: { newValue in
                            if newValue {
                                menuObject.PopUpSize["y"] = 120.0
                            }
                        })
                    
                    Spacer()
                        .frame(width: 20)
                    
                    Button {
                        menuObject.objActive.toggle()
                        menuObject.PopUpSize["y"] = menuObject.objActive ? menuObject.PopUpSize["AnimHeight"] : 610.0
                        menuObject.objOpacity = menuObject.objActive ? 0.8 : 0.0
                        
                        if (menuObject.isCategory) {
                            menuObject.catArray[newCategory] = 0
                            UserDefaults.standard.set(menuObject.catArray, forKey: "CategoryArray")
                        } else {
                            menuObject.expenseArray[newCategory] = 0
                            UserDefaults.standard.set(menuObject.expenseArray, forKey: "ExpenseArray")
                        }
                        
                        isFocused = false
                    } label: {
                        Image("Done_Icon")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(CustomColors.PositiveTint)
                    }
                }
            }
            .offset(y: -20)
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView()
            .environmentObject(MenuClass())
    }
}
