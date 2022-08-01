//
//  ContentView.swift
//  Multiple Hero
//
//  Created by Joe Pham on 2022-08-01.
//

import SwiftUI

struct ContentView: View {

	@State
	private var currentGame: MHGame = MHGame()
	
	var body: some View {
		
		// Swap views in this VStack
		Group {
			if currentGame.isAskingForSettings {
				MHSettingsView(game: $currentGame)
			}
			
			if currentGame.isGameActuallyActive {
				// Player is actively playing
				MHActiveGameView(game: $currentGame)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
