
import UIKit

typealias PDFData = Data

/// Protocol for the PDF manipulation tasks.
protocol PDFService: class {
    /// Merges images to PDF.
    func mergeToPDF(images: [UIImage]) -> PDFData?
    /// Creates a thumbnail from the provided PDF data.
    func thumbnail(from pdfData: PDFData) -> UIImage?
}
