//
//  TabBar.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 8/3/2022.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab:String
    @State var tabPoints : [CGFloat] = []
    @State var isShowed = false
    
    var body: some View {
        
        VStack{
            HStack{
                Button(action: {
                    withAnimation(.spring()){
                        isShowed.toggle()
                    }
                }, label: {
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: UIScreen.main.bounds.width, height: 45, alignment: .center)
                            .cornerRadius(50, corners: [.topLeft,.topRight])
                        Image(systemName: "text.justify")
                            .foregroundColor(Color("SelectedTab"))
                            .frame(width: UIScreen.main.bounds.width)
                    }
                    .offset(x: 0, y: 8.3)
                })
                .buttonStyle(FlatLinkStyle())
            }
            HStack(spacing:0){
                TabBarButton(image: "house", name: "Home", selectedTab: $selectedTab, tabPoints: $tabPoints)
                TabBarButton(image: "viewfinder.circle", name: "Scan", selectedTab: $selectedTab, tabPoints: $tabPoints)
                TabBarButton(image: "photo", name: "View", selectedTab: $selectedTab, tabPoints: $tabPoints)
                TabBarButton(image: "icloud.and.arrow.up", name: "Upload", selectedTab: $selectedTab, tabPoints: $tabPoints)
                TabBarButton(image: "person.3", name: "About", selectedTab: $selectedTab, tabPoints: $tabPoints)
                TabBarButton(image: "gearshape", name: "Setting", selectedTab: $selectedTab, tabPoints: $tabPoints)
            }
            .padding()
            .background(
                Color.white
            )
        }
        .offset(y: isShowed ? 30 : 115)
    }
    
    
    func getCurvePoint()->CGFloat{
        if tabPoints.isEmpty{
            return 10
        }
        else{
            switch selectedTab{
            case "house":
                return tabPoints[0]
            case "viewfinder.circle":
                return tabPoints[1]
            case "photo":
                return tabPoints[2]
            case "icloud.and.arrow.up":
                return tabPoints[3]
            case "person.3":
                return tabPoints[4]
            case "gearshape":
                return tabPoints[5]
            default:
                return 10
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct TabBarButton:View{
    
    var image:String
    var name:String
    @Binding var selectedTab:String
    @Binding var tabPoints:[CGFloat]
    
    var body: some View{
        
        GeometryReader{reader -> AnyView in
            
            
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                if tabPoints.count <= 5{
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                Button(action: {
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)){
                        selectedTab = image
                    }
                }, label: {
                    VStack{
                        Image(systemName: selectedTab == image ? "\(image).fill" : "\(image)")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(Color("SelectedTab"))
                            .offset(y:selectedTab == image ? -10 : 0)
                        Text(name)
                            .font(Font.system(size: 13, weight: .semibold))
                            .foregroundColor(Color("SelectedTab"))
                            .offset(y:selectedTab == image ? -10 : 0)
                    }
                })
                .frame(maxWidth:.infinity, maxHeight: .infinity)
            
            )
        }
        .frame(height: 50)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
