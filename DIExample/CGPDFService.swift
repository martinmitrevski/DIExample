
import Foundation
import PDFKit

/// Class for handling PDF related tasks, such as merging images to PDF, generating thumbnails.
class CGPDFService: PDFService {
    
    /// Merges the provided images into a PDFData.
    func mergeToPDF(images: [UIImage]) -> PDFData? {
        let maxWidth = images.map { (image) -> CGFloat in
            return image.size.width
            }.max()
        let defaultWidth = UIScreen.main.bounds.size.width
        let pdfs = images.map { (image) -> PDFData in
            return self.createPDFDataFromImage(image: image, width: maxWidth ?? defaultWidth)
        }
        
        let out = NSMutableData()
        UIGraphicsBeginPDFContextToData(out, .zero, nil)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return out as Data
        }
        
        for pdf in pdfs {
            guard let dataProvider = CGDataProvider(data: pdf as CFData),
                let document = CGPDFDocument(dataProvider) else {
                    continue
            }
            
            for pageNumber in 1...document.numberOfPages {
                guard let page = document.page(at: pageNumber) else { continue }
                var mediaBox = page.getBoxRect(.mediaBox)
                context.beginPage(mediaBox: &mediaBox)
                context.drawPDFPage(page)
                context.endPage()
            }
        }
        
        context.closePDF()
        UIGraphicsEndPDFContext()
        return out as Data
    }
    
    /// Converts an image to a PDFData.
    private func createPDFDataFromImage(image: UIImage, width: CGFloat) -> PDFData {
        let pdfData = NSMutableData()
        let imgView = UIImageView.init(image: image)
        let ratio: CGFloat = width / image.size.width
        let imageRect = CGRect(x: 0, y: 0, width: width, height: ratio * image.size.height)
        imgView.frame = imageRect
        UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()
        imgView.layer.render(in: context!)
        UIGraphicsEndPDFContext()
        return pdfData as PDFData
    }
    
    /// Generates a thumbnail image of the PDFData.
    func thumbnail(from pdfData: PDFData) -> UIImage? {
        guard let provider = CGDataProvider(data: pdfData as CFData),
            let document = CGPDFDocument(provider),
            let page = document.page(at: 1) else {
                return nil
        }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
        }
        
        return img
    }
    
}
