import Foundation
import ScriptingBridge

if let application = SBApplication(bundleIdentifier: "com.unsignedinteger.Deckset-Paddle") {
  let decksetApplication = application as DecksetApplication

  let decksetWindows = decksetApplication.windows?().compactMap({ $0 as? DecksetWindow })
  let decksetWindow = decksetWindows?.first

  let decksetDocuments = decksetApplication.documents?().compactMap({ $0 as? DecksetDocument })
  let decksetDocument = decksetDocuments?.first

  let tool = DkstCLI(app: decksetApplication, window: decksetWindow, document: decksetDocument)

  do {
    try tool.run()
  } catch {
    print("An error occurred: \(error)")
  }
}
