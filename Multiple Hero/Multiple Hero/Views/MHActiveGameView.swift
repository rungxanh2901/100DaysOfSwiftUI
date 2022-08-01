//
//  MHActiveGameView.swift
//  Multiple Hero
//
//  Created by Joe Pham on 2022-08-01.
//

import SwiftUI

struct MHActiveGameView: View {
	
	@Binding
	var game: MHGame
	
    var body: some View {
        gamePlayingView
    }
	
	@ViewBuilder
	private var gamePlayingView: some View {
		Text("Game playing view here")
			.transition(
				.asymmetric(insertion: .scale, removal: .opacity)
			)
	}
}

struct MHActiveGameView_Previews: PreviewProvider {
    static var previews: some View {
		StatefulPreviewWrapper(MHGame()) { MHActiveGameView(game: $0) }
    }
}