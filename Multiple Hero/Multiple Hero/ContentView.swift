//
//  ContentView.swift
//  Multiple Hero
//
//  Created by Joe Pham on 2022-08-01.
//

import SwiftUI

struct ContentView: View {

	@State
	private var game: MHGame = MHGame()
	
	var body: some View {
		
		// Swap views in this VStack
		Group {
			if game.isAskingForSettings {
				VStack(spacing: 20) {
					Text("Multiplication Hero")
						.font(.largeTitle)
					tablesUpToView
					questionsToBeAskedView
					playButton
				}
				.padding(.horizontal, 20)
			}
			
			if game.isGameActuallyActive {
				// Player is actively playing
				gamePlayingView
			}
		}
	}
	
	@ViewBuilder
	private var tablesUpToView: some View {
		HStack {
			Text("Tables up to:")
			Spacer()
			Stepper("\(game.selectedMultiplicationTable)", value: $game.selectedMultiplicationTable, in: MHGame.reasonableMultiplicationRange)
		}
	}
	
	@ViewBuilder
	private var questionsToBeAskedView: some View {
		HStack {
			Text("Num of questions:")
			Spacer()
			Picker("Number of questions", selection: $game.questionsToBeAskedPosition, content: {
				ForEach(MHGame.questionsToBeAskedOptions, id: \.self) {
					Text("\($0)")
				}
			})
			.pickerStyle(.segmented)
		}
	}
	
	@ViewBuilder
	private var playButton: some View {
		Button("Play") {
			withAnimation(.easeInOut(duration: 0.5)) {
				game.isAskingForSettings.toggle()
				game.isGameActuallyActive.toggle()
			}
		}
		.buttonStyle(.borderedProminent)
	}
	
	@ViewBuilder
	private var gamePlayingView: some View {
		Text("Game playing view here")
			.transition(
				.asymmetric(insertion: .scale, removal: .opacity)
			)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}