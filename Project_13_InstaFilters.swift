//
//  Project_13_InstaFilters.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 16/03/25.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit
import PhotosUI
import SwiftUI

struct Project_13_InstaFilters: View {
  
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
   let scaleRadius: [String: CGFloat] = [
          "CIGaussianBlur": 200,
            "CIVignette": 2,  // Vignette works in a different range
            "CICrystallize": 50,
            "CIUnsharpMask": 10
    ]
    @State private var filterBlurRadius = 0.1
    @State private var filterScale = 1.0
    @State private var filterOverlay = 0.5
    @State private var colorPicker = Color.red
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
   
   
    
    @State private var isConfirmation = false
    
    @AppStorage("filterCount") private var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    func changeFilter(){
        
    }
    func loadImage(){
        Task{
            
            guard let imageDataComing = try await selectedItem?.loadTransferable(type: Data.self) else{ return}
            guard let imageFromData = UIImage(data: imageDataComing) else{ return}
                
                
                let beginImage = CIImage(image: imageFromData)
                currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
                applyProcessing()
            }
        
    }
    func applyProcessing(){
        
        let keyValues: [String: Any] = [
            kCIInputIntensityKey: filterIntensity,
            kCIInputRadiusKey: filterBlurRadius * (scaleRadius[currentFilter.name] ?? 100),
            kCIInputScaleKey: filterScale * 100,
            kCIInputContrastKey: 1.0 + (filterIntensity * 1.5)
         
        ]
        
        for (key , value) in keyValues where currentFilter.inputKeys.contains(key){
            currentFilter.setValue(value, forKey: key)
        }
        
        guard let outputImage = currentFilter.outputImage else {return}
        guard let cgiImage = context.createCGImage(outputImage, from: outputImage.extent) else{return}
        
        let uiImage = UIImage(cgImage: cgiImage)
        processedImage = Image(uiImage: uiImage)
        
    }
    
    @MainActor  func setFilter(_ filter: CIFilter){
        currentFilter = filter
        if selectedItem != nil{
            loadImage()
        }
        filterCount += 1
        
        if filterCount == 3{
            requestReview()
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                  Spacer()
                 
                PhotosPicker(selection: $selectedItem){
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                            .blur(radius: filterBlurRadius)
                            .overlay(
                                colorPicker.opacity(filterOverlay)
                            )
                            .scaleEffect(filterScale)
                    }else{
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                    
                }.buttonStyle(.plain)
                    .onChange(of: selectedItem, loadImage)
                 Spacer()
                
                HStack{
                    Text("Intensity")
                    Slider(value: $filterIntensity, in: 0...1)
                        .onChange(of: filterIntensity, applyProcessing)
                    
                }
                    .disabled(selectedItem == nil )
                
                HStack{
                    Text("Radius")
                    Slider(value: $filterBlurRadius, in: 0...1)
                        .onChange(of: filterBlurRadius , applyProcessing)
                    
                }
                    .disabled(selectedItem == nil  )
                
                HStack{
                    Text("Scale")
                    Slider(value: $filterScale, in: 0...1)
                        .onChange(of: filterScale, applyProcessing)
                    
                    
                }
                    .disabled(selectedItem == nil )
                HStack{
                    Text("Overlay")
                    Slider(value: $filterOverlay, in: 0...1)
                        .onChange(of: filterOverlay, applyProcessing)
                    ColorPicker("", selection: $colorPicker)
                        .labelsHidden()
                    
                }.padding(.vertical)
                    .disabled(selectedItem == nil )
                    
                HStack{
                    Button("Change Filter"){ isConfirmation.toggle()}
                        .confirmationDialog("select Filter", isPresented: $isConfirmation){
                            Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                            Button("Edges") { setFilter(CIFilter.edges()) }
                            Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                            Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                            Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                            Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                            Button("Vignette") { setFilter(CIFilter.vignette()) }
                            Button("Motion Blur") { setFilter(CIFilter.motionBlur()) }
                            Button("Gloom") { setFilter(CIFilter.gloom()) }
                            Button("Gradient") { setFilter(CIFilter.gaussianGradient()) }
                            Button("Cancel", role: .cancel) { }
                            
                        }
                    Spacer()
                    
                    
                }.disabled(selectedItem == nil)
                
            }.padding([.horizontal,.bottom])
            
            
            .navigationTitle("Instafilter")
            .preferredColorScheme(.dark)
            .toolbar{
                ToolbarItem{
                    if let processedImage{
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter Image", image: processedImage))
                    }
                }
            }
            
        }
    }
}

#Preview {
    Project_13_InstaFilters()
        .preferredColorScheme(.dark)
}
