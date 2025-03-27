



import SwiftUI

struct Project_8_MoonShot_ListLayoutView: View {
    let astronautFileData: [String : Project_8_MoonShot_Astronaut] = Bundle.main.decode("astronauts.json")
    let missionFileData: [Project_8_MoonShot_Mission] = Bundle.main.decode("missions.json")
    
    @State private var isGridView = false
    var body: some View {
        NavigationStack{
         
       
            List{
                
               
                ForEach(missionFileData){ item in
                    
                    NavigationLink{
                        Project_8_MoonShot_DetailView(mission: item, astronauts: astronautFileData)
                    }label: {
                        
                        HStack{
                            Image(item.image)
                                .resizable()
                                .scaledToFill()
                                .shadow(color: .black, radius: 50)
                                .frame(width: 66, height: 40)
                                .padding(.horizontal)
                            
                            
                            VStack{
                                
                                Text(item.displayName)
                                    .font(.headline.weight(.heavy))
                                    .foregroundStyle(.white)
                                
                                Text(item.launchDate?.formatted(date: .long , time: .omitted) ?? "N/A")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.5))
                                    .accessibilityLabel(item.formattedDate == "N/A" ? "launch date not available" : "launch date \(item.formattedDate)")
                            }.padding()
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            
                            
                        }.frame(maxWidth: .infinity)
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground) )
                            .padding(.vertical, -6)
                    }
                }
              
                    
                   .background(Color.darkBackground)
                   .listRowBackground(Color.darkBackground)
                   .preferredColorScheme(.dark)
                  
                
            }.listStyle(.plain)
                .background(Color.darkBackground)
               
              
        }
      
    }
  
}


#Preview {
    Project_8_MoonShot_ListLayoutView()
}
