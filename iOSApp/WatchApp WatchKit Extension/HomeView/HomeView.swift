//
//  HomeView.swift
//  WatchApp WatchKit Extension
//
//  Created by Matteo Visotto on 02/07/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appModel: WatchAppModel
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink{
                    TopTenView()
                } label: {
                    Text("Top 10")
                }
                
                if(appModel.userStatus){
                    NavigationLink{
                        Text(appModel.accessToken)
                    } label: {
                        Text("Tracked")
                    }
                }
            }.navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}