//
//  SettingsView.swift
//  Better You
//
//  Created by Joe Pham on 2022-08-23.
//

import SwiftUI

struct SettingsView: View {
	@AppStorage(UserDefaultsKey.hapticsEnabled)
	private var isHapticsEnabled: Bool = true
	
	@AppStorage(UserDefaultsKey.darkModeEnabled)
	private var isDarkModeEnabled: Bool = false
	
	var body: some View {
		NavigationView {
			Form {
				Section(
					header: Text("General")
				) {
					haptics
					darkMode
				}
				
				Section(
					footer: Text("Be careful, this removes all your habit trackers. You have been warned!")
				) {
					Button("Reset to Original", role: .destructive) {
						resetDefaults()
					}
				}
			}
			.navigationTitle("Settings")
		}
	}
}

private extension SettingsView {
	@ViewBuilder
	private var haptics: some View {
		Toggle("Enable Haptics", isOn: $isHapticsEnabled)
			.tint(.teal)
	}
	
	@ViewBuilder
	private var darkMode: some View {
		Toggle("Dark Mode", isOn: $isDarkModeEnabled)
			.tint(.teal)
	}
	
	/// Reset app data
	private func resetDefaults() {
		let defaults = UserDefaults.standard
		let dictionary = defaults.dictionaryRepresentation()
		dictionary.keys.forEach { key in
			defaults.removeObject(forKey: key)
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}
