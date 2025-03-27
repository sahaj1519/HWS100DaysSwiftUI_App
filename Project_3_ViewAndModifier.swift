//
//  Project_3_ViewAndModifier.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 04/03/25.
//

import SwiftUI

struct LargeBlueFont: ViewModifier{     // custom modifier for large blue font
    var text: String
    func body(content: Content) -> some View {
        ZStack{
            content
             Text(text)
                  .font(.largeTitle.weight(.bold))
                  .foregroundColor(.blue)
        }.frame(width: 300, height: 300)
      
     }
    }
     

extension View{
    func LargeBlueFonted(with text: String) -> some View {
        modifier(LargeBlueFont(text: text))
    }
}

struct CapsuleText: View{      // custom structure conforms to view protocol
    var text: String
    var body: some View{     /// View Protocol require only a View body
        Text(text)
            .font(.title)
            .padding()
    
            .background(.blue)
            .clipShape(.capsule)
    }
}
struct watermark: ViewModifier{            //  custom structure conforms to ViewModifier protocol
    
    var text: String
    func body(content: Content) -> some View {       // ViewModifier protocol requirement is a body function with                                                      content parameter of type Content and return some View
        ZStack(alignment: .bottomTrailing){
            content     // content is any view
            
            Text(text)
            
        }.frame(width: 300, height: 300)
    }
}

struct watermarkWithViewExtension: ViewModifier{
    var text: String
    func body(content: Content) -> some View {
      
        ZStack(alignment: .bottomTrailing){
            content     // content is any view
            
            Text(text)
                .foregroundColor(.white)
            
        }.frame(width: 300, height: 300)
    }
}

extension View {                                       //extension of view protocol adding a normal function which                                                        return a modifier so that we do not have to use word                                                               .modifier while applying it instead we simply use it buy                                                                 watermar name
    func watermarked(with text: String) -> some View{
        modifier(watermarkWithViewExtension(text: text))
    }
}
struct Project_3_ViewAndModifier: View {
    var body: some View {
       
        NavigationStack{
            
                 ScrollView{
               
                    CapsuleText(text: "hello world")  // using custom structure CapsuleText(text:)
                        .foregroundStyle(.red)
                    CapsuleText(text: "your name")
                    
                    Color.red
                        .modifier(watermark(text: "Hacking with swift"))    // custom modifier applied on color.red
                    
                    Color.blue
                        .watermarked(with: "hacking with swift")       // custom modifier with view extension
                    
                    Color.black
                        .LargeBlueFonted(with: "hi")
                    
                        .navigationTitle("View And Modifiers")
                        .navigationBarTitleDisplayMode(.large)
                      
                 }
                 .padding(.top)
                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                 //.background(.black)
                
        }
        
            
    }
}

#Preview {
    Project_3_ViewAndModifier()
}
