//
//  MainView.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                VStack{
                    Spacer()
                    Color("SecondaryBackgroundColor").frame(height: UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                }.ignoresSafeArea()
                VStack {
                    MainHeader(tabName: MainViewModel.tabs[viewModel.selectedTab].tabName)
                        .frame(height: appState.isUserLoggedIn ? 60 : 50)
                        .padding(.horizontal)
                    
                    TabView(selection: $viewModel.selectedTab){
                        HomeView().tag(0).gesture(DragGesture())
                        Color.blue.tag(1)
                        Color.yellow.tag(2)
                        SettingView(showLogin: $viewModel.showLogin).tag(3).gesture(DragGesture())
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    AppTabBar(selectedTab: $viewModel.selectedTab, elements: MainViewModel.tabs, centralButtonAction: {
                        viewModel.showAddProduct.toggle()
                    })
                            .frame(height: 33)
                            .padding(.bottom, 10)
                            .padding(.horizontal)
                            .background(Color("SecondaryBackgroundColor"))
        
                    
                }
            }.navigationBarHidden(true)
                
           
        }.fullScreenCover(isPresented: $viewModel.showLogin) {
            LoginView($viewModel.showLogin)
        }
        .sheet(isPresented: $viewModel.showAddProduct) {
            AddProductView(isShown: $viewModel.showAddProduct)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(AppState.shared)
    }
}
