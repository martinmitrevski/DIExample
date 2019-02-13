
import PDFKit

@available(iOS 11, *)
class PDFKitService: PDFService {
    
    /// Merges the provided images into a PDFData.
    func mergeToPDF(images: [UIImage]) -> PDFData? {
        let document = PDFDocument()
        var index = 0
        for image in images {
            if let page = PDFPage(image: image) {
                document.insert(page, at: index)
                index += 1
            }
        }
        
        return document.dataRepresentation()
    }
    
    /// Generates a thumbnail image of the PDFData.
    func thumbnail(from pdfData: PDFData) -> UIImage? {
        guard let page = PDFDocument(data: pdfData)?.page(at: 0) else {
            return nil
        }
        
        let pageSize = page.bounds(for: .mediaBox)
        let defaultWidth: CGFloat = 240
        let pdfScale = defaultWidth / pageSize.width
        
        // Apply if you're displaying the thumbnail on screen
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale,
                                height: pageSize.height * scale)
        
        return page.thumbnail(of: screenSize, for: .mediaBox)
    }
    
}
