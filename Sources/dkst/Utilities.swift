import PathKit

public class Utilities {
  public static func getCurrentDocument(decksetApp: DecksetApplication) -> DecksetDocument? {
    let decksetDocuments = decksetApp.documents?().compactMap({ $0 as? DecksetDocument })
    return decksetDocuments?.first
  }

  public static func getCurrentWindow(decksetApp: DecksetApplication) -> DecksetWindow? {
    let decksetWindows = decksetApp.windows?().compactMap({ $0 as? DecksetWindow })
    return decksetWindows?.first
  }

  public static func foo() -> String {
    return "bar"
  }

  public static func createOutputPath(out: String, file: String, format: String) -> Path {
    return Path(out) + Path(file.replacingOccurrences(of: ".md", with: "." + format))
  }
}
