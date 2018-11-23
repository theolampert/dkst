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
          Argument<String>("outputPath", description: HelpText.outputPath),
          Option<String>("inputFile", default: "", description: HelpText.inputFile),
          Option<String>("format", default: "PDF", description: HelpText.format),
          Flag("printAllSteps", default: false, description: HelpText.printAllSteps),
          Flag("includePresenterNotes", default: false, description: HelpText.includePresenterNotes),
          description: HelpText.exportDescription
        ) { (outputPath: String, inputFile: String, format: String, printAllSteps: Bool, includePresenterNotes: Bool) in

          var outPath = outputPath
          let filePath = NSURL(fileURLWithPath: inputFile).path

          var document = Utilities.getCurrentDocument(decksetApp: self.app)
          var window = Utilities.getCurrentWindow(decksetApp: self.app)

          // Filepath supplied, open the app and grab documents and windows again
          if filePath != nil {
            self.app.open?(filePath)
            document = Utilities.getCurrentDocument(decksetApp: self.app)
            window = Utilities.getCurrentWindow(decksetApp: self.app)
          }

          // Assume no document is open and bail out.
          guard let documentName: String = document!.name ?? filePath else {
            print(HelpText.noInput)
            return
          }

          if Utilities.isDirectory(path: outPath) && format == "PDF" {
            outPath = Utilities.createOutputPath(out: outputPath, file: documentName, format: format)
          }

          let absoluteOutputPath = NSURL(fileURLWithPath: outPath).absoluteURL
          document?.exportTo?(
            absoluteOutputPath,
            as: format,
            printAllSteps: printAllSteps,
            includePresenterNotes: includePresenterNotes
          )
          if filePath != nil {
            window?.close?()
          }
        }

        $0.command("present", description: HelpText.presentDescription) {
          let document = Utilities.getCurrentDocument(decksetApp: self.app)
          document?.present?()
        }

        $0.command("rehearse", description: HelpText.rehearseDescription) {
          let document = Utilities.getCurrentDocument(decksetApp: self.app)
          document?.rehearse?()
        }

        $0.command("open",
          Argument<String>("path", description: HelpText.openPath),
          description: "Open a Deckset presentation."
        ) { (path: String) in
          let filePath = NSURL(fileURLWithPath: path).path
          self.app.open?(filePath)
        }

        $0.command("preview", description: HelpText.previewDescription) {
          let isPreview = self.app.preview
          self.app.setPreview?(!isPreview!)
        }

        $0.command("quit", description: HelpText.quitDescription) {
          self.app.quit?()
        }

        $0.command("slide-index", 
          Option<String>("index", default: "", description: HelpText.index),
          description: HelpText.slideIndexDescription) 
        { (index: String) in
          let document = Utilities.getCurrentDocument(decksetApp: self.app)
          let nextIndex = Int(index) ?? document?.slideIndex ?? 0
          document?.setSlideIndex?(nextIndex)
          print(String(nextIndex))
        }
      }
    }

    public func run() throws {
      let cli = self.configureCLI()
      cli.run()
    }
}
