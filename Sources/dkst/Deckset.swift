import AppKit
import ScriptingBridge

@objc public protocol SBObjectProtocol: NSObjectProtocol {
    func get() -> Any!
}

@objc public protocol SBApplicationProtocol: SBObjectProtocol {
    func activate()
    var delegate: SBApplicationDelegate! { get set }
    var isRunning: Bool { get }
}

// MARK: DecksetGenericMethods
@objc public protocol DecksetGenericMethods {
    @objc optional func close() // Close a document.
}

// MARK: DecksetApplication
@objc public protocol DecksetApplication: SBApplicationProtocol {
    @objc optional func documents() -> SBElementArray
    @objc optional func windows() -> SBElementArray
    @objc optional var name: String { get } // The name of the application.
    @objc optional var frontmost: Bool { get } // Is this the active application?
    @objc optional var version: String { get } // The version number of the application.
    @objc optional var preview: Bool { get } // Show the preview window?
    @objc optional func open(_ path: String!) // Open a document.
    @objc optional func quit() // Quit the application.
    @objc optional func setPreview(_ preview: Bool) // Show the preview window?
}
extension SBApplication: DecksetApplication {}

// MARK: DecksetSlide
@objc public protocol DecksetSlide: SBObjectProtocol, DecksetGenericMethods {
    @objc optional var notes: String { get } // The notes of the text.
    @objc optional var pdfData: Data { get } // The slide as PDF.
    @objc optional func setNotes(_ notes: String!) // The notes of the text.
    @objc optional func setPdfData(_ pdfData: Data!) // The slide as PDF.
}
extension SBObject: DecksetSlide {}

// MARK: DecksetDocument
@objc public protocol DecksetDocument: SBObjectProtocol, DecksetGenericMethods {
    @objc optional func slides() -> SBElementArray
    @objc optional var name: String { get } // Its name.
    @objc optional var modified: Bool { get } // Has it been modified since the last save?
    @objc optional var file: URL { get } // Its location on disk, if it has one.
    @objc optional var slideIndex: Int { get } // Index of the selected slide
    @objc optional func present() // Start the presentation.
    @objc optional func exportTo(_ to: URL!, as: String!, printAllSteps: Bool, includePresenterNotes: Bool) // Export the presentation.
    @objc optional func rehearse() // Rehearse the presentation.
    @objc optional func setSlideIndex(_ slideIndex: Int) // Index of the selected slide
}
extension SBObject: DecksetDocument {}

// MARK: DecksetWindow
@objc public protocol DecksetWindow: SBObjectProtocol, DecksetGenericMethods {
    @objc optional var name: String { get } // The title of the window.
    @objc optional func id() -> Int // The unique identifier of the window.
    @objc optional var index: Int { get } // The index of the window, ordered front to back.
    @objc optional var bounds: NSRect { get } // The bounding rectangle of the window.
    @objc optional var closeable: Bool { get } // Does the window have a close button?
    @objc optional var miniaturizable: Bool { get } // Does the window have a minimize button?
    @objc optional var miniaturized: Bool { get } // Is the window minimized right now?
    @objc optional var resizable: Bool { get } // Can the window be resized?
    @objc optional var visible: Bool { get } // Is the window visible right now?
    @objc optional var zoomable: Bool { get } // Does the window have a zoom button?
    @objc optional var zoomed: Bool { get } // Is the window zoomed right now?
    @objc optional var document: DecksetDocument { get } // The document whose contents are displayed in the window.
    @objc optional func setIndex(_ index: Int) // The index of the window, ordered front to back.
    @objc optional func setBounds(_ bounds: NSRect) // The bounding rectangle of the window.
    @objc optional func setMiniaturized(_ miniaturized: Bool) // Is the window minimized right now?
    @objc optional func setVisible(_ visible: Bool) // Is the window visible right now?
    @objc optional func setZoomed(_ zoomed: Bool) // Is the window zoomed right now?
}
extension SBObject: DecksetWindow {}

