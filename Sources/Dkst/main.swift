import Foundation
import ScriptingBridge
import DkstLib

if let application = SBApplication(bundleIdentifier: "com.unsignedinteger.Deckset-Paddle") {
  let decksetApplication = application as DecksetApplication

  let tool = DkstCLI(app: decksetApplication)

  do {
    try tool.run()
  } catch {
    print("An error occurred: \(error)")
  }
}
