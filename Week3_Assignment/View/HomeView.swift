//
//  HomeView.swift
//  Week3_Assignment
//
//  Created by Rayaheen Mseri on 21/09/1446 AH.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = NewsHomeViewModel()
    @State var hasLoaded: Bool = false
    @State var selectedNews: News? = nil
    @EnvironmentObject var darkModeManager: DarkModeManager
    @State var searchText = ""
    var body: some View {
        NavigationStack{
            VStack{
                //print the url and those thing in project
                Divider()
                    .padding(.horizontal)
                    .padding(.top, 2)
                
                Spacer()
                
                if !hasLoaded{
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                else{
                    if !viewModel.isLoading && viewModel.news.isEmpty{
                        Text("No News Found")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }else{
                        ScrollView{
                            ForEach(searchNews()){ news in
                                VStack{
                                    NewsSectionView(news: news, isDarkMode: darkModeManager.isDarkMode)
                                    Divider()
                                        .padding([.top, .bottom], 4)
                                }
                                .padding(.horizontal)
                                .onTapGesture {
                                    selectedNews = news
                                }
                                
                            }
                            
                            if !viewModel.news.isEmpty && viewModel.currentPage <= viewModel.totalPages {
                                Button(action: {
                                    viewModel.loadNews()
                                }) {
                                    Text("Load More")
                                        .font(.headline)
                                        .foregroundColor(darkModeManager.isDarkMode ? .black : .white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(darkModeManager.isDarkMode ? .white : .black)
                                        .cornerRadius(20)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Text("Today's News 🗞️")
                        .font(.largeTitle)
                        .bold()
                }
            }
            
        }
        .padding(.top, 5)
        .searchable(text: $searchText)
        .onAppear{
            if !hasLoaded{
                viewModel.loadNews()
                hasLoaded = true
            }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.erorrMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
        .fullScreenCover(item: $selectedNews) { news in
            // Present the NewsDetailsView when selectedNews is not nil
            NewsDetailsView(news: news)
        }
        .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
    }
    
    
    func searchNews() -> [News]{
        if searchText.isEmpty{
            return viewModel.news
        }
        else{
            let filteredNews = viewModel.news.filter { $0.title?.lowercased().contains(searchText.lowercased()) == true }
            return filteredNews
        }
    }
}

#Preview {
    HomeView()
}
