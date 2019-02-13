
import UIKit
import WebKit
import GirdersSwift

class ViewController: UIViewController {
    
    private lazy var pdfService: PDFService = Container.resolve()
    
    private var pdfView: WKWebView!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadPDF()
    }
    
    private func setupWebView() {
        pdfView = WKWebView(frame: containerView.frame)
        containerView.addSubview(pdfView)
        pdfView.fillSuperView()
    }
    
    private func loadPDF() {
        let images = loadImages()
        if let pdfData = pdfService.mergeToPDF(images: images) {
            let baseURL = URL(string: "https://example.com")!
            pdfView.load(pdfData,
                         mimeType: "application/pdf",
                         characterEncodingName: "utf-8",
                         baseURL: baseURL)
        }
    }

    private func loadImages() -> [UIImage] {
        return [UIImage(named: "sample1.jpg")!,
                UIImage(named: "sample2.png")!]
    }

}

