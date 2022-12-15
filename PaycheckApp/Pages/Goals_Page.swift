//
//  Goals_Page.swift
//  PaycheckApp
//
//  Created by Juan Mercado on 12/4/22.
//

import SwiftUI

struct Goals_Page: View {
    @EnvironmentObject var menuObject: MenuClass
    
    var body: some View {
        ZStack {
            Image("Background_V2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)
            
            VStack {
                VStack {
                    HStack {
                        Button {
                            //menuObject.isSideMenuActive = !menuObject.isSideMenuActive
                            //menuObject.stackPos["x"] = menuObject.isSideMenuActive ? 125 : 0
                            //menuObject.stackPos["y"] = menuObject.isSideMenuActive ? 125 : 50
                        } label: {
                            Image("Dash_Icon")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        
                        Spacer()
                            .frame(width: 20)
                        
                        Text("MY GOALS")
                            .multilineTextAlignment(.leading)
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .black))
                            .frame(width: 225)
                    }
                }
                .offset(x: -25, y: -5)
                
                Spacer()
                    .frame(height: 10)
                
                ScrollView {
                    
                }
            }
            .offset(y: 50)
            
        }
    }
}

struct Goals_Page_Previews: PreviewProvider {
    static var previews: some View {
        Goals_Page()
            .environmentObject(MenuClass())
    }
}
