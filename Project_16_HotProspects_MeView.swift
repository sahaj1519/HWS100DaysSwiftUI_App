//
//  Project_16_HotProspects_MeView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 20/03/25.
//
import CoreImage.CIFilterBuiltins
import SwiftUI

struct Project_16_HotProspects_MeView: View {
    
    @AppStorage("name") private var enterName = "Roger"
    @AppStorage("emailAddress") private var enterEmailAddress = "Roger12@.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State private var yourQrCode = UIImage()
    
    func generateQrCode(from: String) -> UIImage{
        filter.message = Data(from.utf8)
        
        if let outputImage = filter.outputImage{  //give image data
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.cicle") ?? UIImage()
    }
    
    func updateYourQrCode(){
        yourQrCode = generateQrCode(from: "\(enterName)\n\(enterEmailAddress)")
    }
    
    
    // body start here
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Your Name", text: $enterName)
                        .textContentType(.name)
                        .font(.title)
                    
                    TextField("Your Email Address" ,text: $enterEmailAddress)
                        .textContentType(.emailAddress)
                        .font(.title)
                    
                }
                
                Section{
                    Image(uiImage: yourQrCode)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320, height: 300)
                        .contextMenu{
                            
                            ShareLink(item: Image(uiImage: yourQrCode), preview: SharePreview("we need to save your QrCode", image: Image(uiImage: yourQrCode)))
                        }
                        
                    
                }
            }
            .onAppear(perform: updateYourQrCode)
            .onChange(of: enterName, updateYourQrCode)
            .onChange(of: enterEmailAddress, updateYourQrCode)
            .navigationTitle("Your Qr Code")
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    Project_16_HotProspects_MeView()
}
