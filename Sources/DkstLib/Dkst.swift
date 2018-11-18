import Foundation
import Commander

public final class DkstCLI {
    private let app: DecksetApplication

    public init(app: DecksetApplication) {
      self.app = app
    }

    private func configureCLI() -> Group {
      return Group {
        $0.command("export",
          Argument<String>("outputPath", description: "Export path."),
          Option<String>("inputFile", default: "", description: "Input path. If not supplied uses the open presentation."),
          Option<String>("format", default: "PDF", description: "The format to export in, valid options are [PDF, JPEG, PNG]. Defaults to PDF."),
          Flag("printAllSteps", default: false, description: "Print all steps."),
          Flag("includePresenterNotes", default: false, description: "Include presenter notes."),
          description: "Export the current Deckset presentation."
        ) { (outputPath: String, inputFile: String, format: String, printAllSteps: Bool, includePresenterNotes: Bool) in

          var outPath = outputPath
          let filePath = NSURL(fileURLWithPath: inputFile).path

          var document = Utilities.getCurrentDocument(decksetApp: self.app)
          var window = Utilities.getCurrentWindow(decksetApp: self.app)

          // Assume no document is open and bail out.
          if document?.name == nil && filePath == nil {
            print("No document open or inputFile supplied.")
            return
          }

          // Filepath supplied, open the app and grab documents and windows again
          if (filePath != nil) {
            self.app.open?(filePath)
            document = Utilities.getCurrentDocument(decksetApp: self.app)
            window = Utilities.getCurrentWindow(decksetApp: self.app)
          }

          if Utilities.isDirectory(path: outPath) && format == "PDF" {
            if let fileName = document?.name ?? filePath {
              outPath = Utilities.createOutputPath(out: outputPath, file: fileName, format: format)
            }
          }

          let absoluteOutputPath = NSURL(fileURLWithPath: outPath).absoluteURL
          document?.exportTo?(
            absoluteOutputPath,
            as: format,
            printAllSteps: printAllSteps,
            includePresenterNotes: includePresenterNotes
          )
          if (filePath != nil) {
            window?.close?()
          }
        }

        $0.command("present", description: "Present a Deckset presentation.") {
          let document = Utilities.getCurrentDocument(decksetApp: self.app)
          document?.present?()
        }

        $0.command("rehearse", description: "Rehearse a Deckset presentation.") {
          let document = Utilities.getCurrentDocument(decksetApp: self.app)
          document?.rehearse?()
        }

        $0.command("open",
          Argument<String>("path", description: "Path to a Deckset presentation."),
          description: "Open a Deckset presentation."
        ) { (path: String) in
          let filePath = NSURL(fileURLWithPath: path).path
          self.app.open?(filePath)
        }

        $0.command("preview", description: "Toggle the Deckset preview window.") {
          let isPreview = self.app.preview
          self.app.setPreview?(!isPreview!)
        }

        $0.command("quit", description: "Quit Deckset.") {
          self.app.quit?()
        }
      }
    }

    public func run() throws {
      let cli = self.configureCLI()
      cli.run()
    }
}
