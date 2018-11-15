import Foundation
import Commander

public final class DkstCLI {
    private let app: DecksetApplication
    private let window: DecksetWindow?
    private let document: DecksetDocument?
    private let cli: Commander.Group

    public init(app: DecksetApplication, window: DecksetWindow?, document: DecksetDocument?) {
      self.app = app
      self.window = window
      self.document = document

      self.cli = Group {
        $0.command("export",
          Argument<String>("path", description: "Export path."),
          Option("format", default: "PDF", description: "The format to export in, valid options are [PDF, JPEG, PNG]. Defaults to PDF."),
          Flag("printAllSteps", default: false, description: "Print all steps."),
          Flag("includePresenterNotes", default: false, description: "Include presenter notes."),
          description: "Export the current Deckset presentation."
        ) { (path: String, format: String, printAllSteps: Bool, includePresenterNotes: Bool) in

          let filePath = NSURL(fileURLWithPath: path).absoluteURL
          document?.exportTo?(
            filePath,
            as: format,
            printAllSteps: printAllSteps,
            includePresenterNotes: includePresenterNotes
          )
        }

        $0.command("present", description: "Present a Deckset presentation.") {
          document?.present?()
        }

        $0.command("rehearse", description: "Rehearse a Deckset presentation.") {
          document?.rehearse?()
        }

        $0.command("open",
          Argument<String>("path", description: "Path to a Deckset presentation."),
          description: "Open a Deckset presentation."
        ) { (path: String) in
          let filePath = NSURL(fileURLWithPath: path).path
          app.open?(filePath)
        }

        $0.command("preview", description: "Toggle the Deckset preview window.") {
          let isPreview = app.preview
          app.setPreview?(!isPreview!)
        }

        $0.command("quit", description: "Quit Deckset.") {
          app.quit?()
        }
      }
    }

    public func run() throws {
      self.cli.run()
    }
}
