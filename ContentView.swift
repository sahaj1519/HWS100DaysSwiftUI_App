//
//  ContentView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 03/03/25.
//

import SwiftUI

struct ContentView: View {
    
  
    var body: some View {
        NavigationStack{
          
               VStack{
                    
                    List{
                        
                      
                            /** NavigationLink("Project-1-WeSplit"){
                             Project_1_WeSplit()
                             
                             }
                             NavigationLink("Project-2-Guess the flag"){
                             Project_2_GuessTheFlag()
                             }  
                             NavigationLink("Project_3_ViewAndModifier"){
                             Project_3_ViewAndModifier()
                             }
                             
                             NavigationLink("Project_4_BetterRest"){
                             Project_4_BetterRest()
                             }
                             NavigationLink("Project_5_WordScramble"){
                             Project_5_WordScramble()
                             }
                            NavigationLink("Project_6_Animation"){
                                Project_6_Animation()
                            }
                            NavigationLink("Consolidation_Project_1To3"){
                                Consolidation_Project_1To3()
                            }
                            NavigationLink("Consolidation_Project_4To6"){
                                Consolidation_Project_4To6()
                            }
                            NavigationLink("Project_7_iExpense"){
                             Project_7_iExpense()
                           }
                           NavigationLink("Project_8_MoonShot"){
                                Project_8_MoonShot()
                            }
                          NavigationLink("Project_9_Navigation" ){
                            Project_9_Navigation()
                          }
                         NavigationLink("Consolidation_Project_7To9"){
                            Consolidation_Project_7To9()
                         }
                        NavigationLink("Project_10_CupcakeCorner"){
                            Project_10_CupcakeCorner()
                        }
                        
                         NavigationLink("Project_11_BookWorm"){
                             Project_11_BookWorm()
                       }
                        NavigationLink("Project_12_SwiftDataProject"){
                            Project_12_SwiftDataProject()
                        }
                        NavigationLink("Consolidation_Project_10To12"){
                            Consolidation_Project_10To12()
                        }
                        NavigationLink("Project_13_InstaFilters"){
                            Project_13_InstaFilters()
                        }
                        NavigationLink("Project_14_BucketList"){
                            Project_14_BucketList()
                        }
                        // Project_15_AccessibilitySandbox has nothing so not made
                        
                        NavigationLink("Consolidation_Project_13To15"){
                            Consolidation_Project_13To15()
                        }
                        NavigationLink("Project_16_HotProspects"){
                            Project_16_HotProspects()
                        }
                        NavigationLink("Project_17_Flashzilla"){
                            Project_17_Flashzilla()
                        }
                        NavigationLink("Project_18_LayoutAndGeometry"){
                             Project_18_LayoutAndGeometry()
                        }
                        NavigationLink("Consolidation_Project_16To18"){
                            Consolidation_Project_16To18()
                        }
                        NavigationLink("Project_19_SnowSeeker"){
                            Project_19_SnowSeeker()
                        }  **/
                    }
                   
                }
              
                .navigationTitle("Projects")
                .navigationBarTitleDisplayMode(.large)
                .preferredColorScheme(.dark)
                
    
       }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
