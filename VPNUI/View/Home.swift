//
//  Home.swift
//  VPNUI
//
//  Created by Sopnil Sohan on 15/9/21.
//

import SwiftUI

struct Home: View {
    
    @State var isConnected = false
    //Current Server...
    @State var currentServer: Server = server.first!
    @State var changeServer = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Button {
                    
                } label: {
                    Image(systemName: "circle.grid.cross")
                        .font(.title2)
                        .padding(12)
                        .background(
                            
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder()
                                .opacity(0.25)
                                
                        )
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.title2)
                        .padding(12)
                        .background(
                            
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder()
                                .opacity(0.25)
                                
                        )
                }
            }
            .overlay(
                //Attributed Text...
                Text("MiVPN")
                    .font(.title2.bold())
                    .foregroundColor(.white)
            )
            //power Button...
            PowerButton()
                
                //Status...
            VStack {
                
                Label {
                    
                    Text(isConnected ? "Connected" : "Not Connected")
                } icon: {
                    
                    Image(systemName: isConnected ? "checkmark.shield" : "shield.slash")
                }
                .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                HStack {
                    
                    HStack {
                        
                        Image(systemName: "arrow.down.circle")
                            .font(.title2)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Download")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            
                            Text("\(isConnected ? "60.0" : "0") KB/s")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "arrow.up.circle")
                            .font(.title2)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Upload")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Text("\(isConnected ? "27.5" : "0") KB/s")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
            }
                .frame(width: getRect().width - 100)
        }
            .animation(.none, value: isConnected)
            //Max fram ...
            .frame(height: 120)
            .padding(.top, getRect().height < 750 ? 20 : 40)
            //why using maax fram...
            //it will be useful to fit the content to small iPhone...
                
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Background()
        )
        //Blur View when Server page shows...
        .overlay(
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)).opacity(0.80))
                .opacity(changeServer ? 1 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        changeServer.toggle()
                    }
                }
        )
        .overlay(BottomSheet(), alignment: .bottom)
        .ignoresSafeArea(.container, edges: .bottom)
        //Since the theam is black..
        //using always dark mood...
        .preferredColorScheme(.dark)
    }
    //Bottom Sheet....
    @ViewBuilder
    func BottomSheet()->some View {
        
        VStack(spacing: 0){
            
            //Current Server...
            HStack{
                
                Image(currentServer.flag)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 6){
                    
                    Text(currentServer.name)
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(isConnected ? "Currently Connected" : "Currently Selected")
                        .font(.caption2.bold())
                }
                Spacer(minLength: 10)
                
                //Change Server Button....
                Button {
                    withAnimation {
                        changeServer.toggle()
                    }
                } label: {
                    
                    Text(changeServer ? "Exit" : "Change")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(width: 110, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.white.opacity(0.25), lineWidth: 2)
                                
                        )
                        .foregroundColor(.white)
                }
            }
            .frame(height: 50)
            .padding(.horizontal)
            
            Divider()
                .padding(.top)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 18) {
                    //Filtered servers....
                    //Not showing selected One...
                    ForEach(server.filter{
                        $0.id != currentServer.id
                    }){ server in
                        
                        VStack(spacing: 12){
                            
                            HStack{
                                
                                VStack(alignment: .leading, spacing: 8){
                                    
                                    HStack{
                                        Image(server.flag)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                        
                                        Text(server.name)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                
                                Label {
                                    Text("Available, ping 992ms")
                                } icon: {
                                    Image(systemName: "checkmark")
                                }
                                .foregroundColor(.green)
                                .font(.caption2)
                                }
                                                                    
                                Spacer(minLength: 10)
                                
                                //Change Server Button....
                                Button {
                                    withAnimation {
                                        changeServer.toggle()
                                        currentServer = server
                                        isConnected = false
                                    }
                                } label: {
                                    
                                    Text("Change")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .frame(width: 100, height: 45)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(Color.white.opacity(0.25), lineWidth: 2)
                                                
                                        )
                                        .foregroundColor(.white)
                                }
                                
                                Button  {
                                    
                                } label: {
                                    
                                    Image(systemName: "square.and.arrow.up")
                                        
                                        
                                       .frame(width: 45, height: 45)
                                       .background(
                                            RoundedRectangle(cornerRadius: 10)
                                               .strokeBorder(Color.white.opacity(0.25), lineWidth: 2)
                                    )
                                    .foregroundColor(.white)
                                }
                            }
                            .frame(height: 50)
                            .padding(.horizontal)
                            
                            Divider()
                        }
                    }
                }
                .padding(.top, 25)
                .padding(.bottom,getSafeArea().bottom)
            }
            .opacity(changeServer ? 1 : 0)
        }
        .frame(maxWidth: .infinity)
        //Max Height...
        .frame(height: getRect().height / 2.5, alignment: .top)
        .padding()
        .background(
            
            Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))
                .clipShape(CustomCorners(redius: 35, corners: [.topLeft,.topRight]))
        )
        //Safe Area wont show on priviews...
        //Showing only 50 pixels of height...
        .offset(y: changeServer ? 0 : (getRect().height / 2.5) - (50 + getSafeArea().bottom))
    }
    
    @ViewBuilder
    func Background()-> some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))]), startPoint: .top, endPoint: .bottom)
            
            //using position for stars...
            let stars: [CGPoint] = [
                
                CGPoint(x: 15, y: 190),
                CGPoint(x: 25, y: 250),
                CGPoint(x: 20, y: 350),
                CGPoint(x: 50, y: 450),
                CGPoint(x: 59, y: 550),
                CGPoint(x: 100, y:750),
                CGPoint(x: 90, y: 369),
                CGPoint(x: 120, y: 350),
                CGPoint(x: 145, y: 600),
                CGPoint(x: 200, y: 550),
                CGPoint(x: getRect().width - 30 , y: 240),
            ]
            
            ForEach(stars,id: \.x) { star in
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 5, height: 5)
                    .position(star)
                    .offset(y: getRect().height < 750 ? -20 : 0)
                    
            }
        }
        .ignoresSafeArea()
    }
    @ViewBuilder
    func PowerButton()-> some View {
        
        Button {
            
            withAnimation {
                isConnected.toggle()
            }
            
        } label: {
            
            ZStack {
                
                Image(systemName: "power")
                    .font(.system(size: 65, weight: .bold))
                    .foregroundColor(isConnected ? .white :  Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.80))
                
                //Scaling Down image and showing Status....
                    .scaleEffect(isConnected ? 0.7 : 1)
                    .offset(y: isConnected ? -30 : 0)
                
                Text("DISCONNECT")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isConnected ? 1 : 0)
             }
                //Max Frame...
                .frame(width: 190, height: 190)
                .background(
                    ZStack {
                        //Rings...
                        Circle()
                            .trim(from: isConnected ? 0 : 0.3, to: isConnected ? 1 :  0.5)
                            .stroke(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)).opacity(0.5)]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round)
                            )
                        //Shadows...
                            .shadow(color: Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), radius: 5, x: 1, y: -4)
                        
                        Circle()
                            .trim(from: isConnected ? 0 : 0.3, to: isConnected ? 1 : 0.55)
                            .stroke(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).opacity(0.5)]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round)
                            )
                        //Shadows...
                            .shadow(color: Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), radius: 5, x: 1, y: -4)
                            .rotationEffect(.init(degrees: 160))
                        
                        //Main Little Ring...
                        Circle()
                            .stroke(
                                Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))
                                    .opacity(0.02),
                                lineWidth: 11
                            )
                            //Toggling Shadow when button is Clicked...
                            .shadow(color: Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)).opacity(isConnected ? 0.04 : 0.0), radius: 5, x: 1, y: -4)
                    }
                )
        }
        .padding(.top, getRect().height < 750 ? 30 : 100)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//Extending view to get Screen Size and Frame...
extension View {
    
    func getRect()->CGRect{
        UIScreen.main.bounds
    }
    
    func getSafeArea()->UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}
