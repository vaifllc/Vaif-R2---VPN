//
//  LogsViewController.swift
//  VaifR2
//
//  Created by VAIF on 1/5/23.
//

import UIKit


class LogsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    private let viewModel: LogsViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: LogsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "Logs", bundle: nil)
    }

    deinit {
        if let file = fileToDelete {
            try? FileManager.default.removeItem(at: file)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor()
        textView.layoutManager.allowsNonContiguousLayout = false
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.textColor = .normalTextColor()
        textView.text = ""
        textView.setContentOffset(CGPoint(x: 0, y: textView.contentSize.height), animated: true)
        viewModel.loadLogs { logs in
            DispatchQueue.main.async {
                self.textView.text = logs
            }
        }
        
        navigationItem.title = viewModel.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
    }
    
    // MARK: - Private

    private var fileToDelete: URL?

    @objc private func share(_ item: UIBarButtonItem) {
        let file = FileManager.default.temporaryDirectory.appendingPathComponent("\(viewModel.title).log")
        guard (try? self.textView.text.write(to: file, atomically: true, encoding: .utf8)) != nil else {
            return
        }
        fileToDelete = file // Save file so it can be deleted before closing this VC.
        let activityViewController = UIActivityViewController(activityItems: [file], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = item
        navigationController?.present(activityViewController, animated: true, completion: nil) // File can't be deleted in this completion handler, because it is called before sharing is finished.
    }
}

