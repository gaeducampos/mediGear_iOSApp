//
//  PDFOrderViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 12/5/23.
//

import UIKit
import PDFKit

class PDFOrderViewController: UIViewController {
    let pdfBase64: OrderPDF
    
    init(pdfBase64: OrderPDF) {
        self.pdfBase64 = pdfBase64
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let pdfData = Data(base64Encoded: pdfBase64.pdf) {
            let pdfDocument = PDFDocument(data: pdfData)
            let pdfView = PDFView(frame: view.bounds)
            pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pdfView.document = pdfDocument
            view.addSubview(pdfView)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
