import Foundation

public class Utilities {
  public static func getCurrentDocument(decksetApp: DecksetApplication) -> DecksetDocument? {
    let decksetDocuments = decksetApp.documents?().compactMap({ $0 as? DecksetDocument })
    return decksetDocuments?.first
  }

  public static func getCurrentWindow(decksetApp: DecksetApplication) -> DecksetWindow? {
    let decksetWindows = decksetApp.windows?().compactMap({ $0 as? DecksetWindow })
    return decksetWindows?.first
  }

  public static func createOutputPath(out: String, file: String, format: String) -> String {
    return out + file.replacingOccurrences(of: ".md", with: "." + format)
  }

  public static func isDirectory(path: String) -> Bool {
    var isDirectory: ObjCBool = false
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
      return isDirectory.boolValue
    } else {
      return false
    }
  }
}
