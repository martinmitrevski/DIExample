
import Foundation
import GirdersSwift

/// Class for managing dependencies in the app.
class DIService {
    
    static func injectDependencies() {
        Container.addSingleton { () -> PDFService in
            if #available(iOS 11, *) {
                return PDFKitService()
            } else {
                return CGPDFService()
            }
        }
    }
    
}
