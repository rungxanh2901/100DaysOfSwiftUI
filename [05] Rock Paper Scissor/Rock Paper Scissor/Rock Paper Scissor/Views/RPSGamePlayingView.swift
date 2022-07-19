//
//  RPSGamePlayingView.swift
//  Rock Paper Scissor
//
//  Created by Joe Pham on 2022-07-18.
//

import SwiftUI

struct RPSGamePlayingView: View {
	@Binding var game: RPSGame
	
    var body: some View {
		VStack {
			Group {
				let computerMoveName = game.computerRandomGesture.rawValue
				Text("Computer move is \(computerMoveName)")
					.font(RPSFont.Lora)
					.foregroundColor(.white)
					.shadow(radius: 5, y: 5)
				
				RPSGestureImageView(
					gesture: game.computerRandomGesture
				)
				.frame(width: 120, height: 120)
			}
//			.padding()
			
			
			Group {
				RPSGameModeView(mode: game.gameMode)
					.font(RPSFont.LoraBold)
					.foregroundColor(.white)
					.shadow(radius: 5, y: 5)
				
				RPSGestureSelectionView(game: $game)
			}
//			.padding()
		}
    }
}

struct RPSGamePlayingView_Previews: PreviewProvider {
	static var previews: some View {
		StatefulPreviewWrapper(RPSGame()) {
			RPSGamePlayingView(game: $0)
		}
		.preferredColorScheme(.dark)
	}
}