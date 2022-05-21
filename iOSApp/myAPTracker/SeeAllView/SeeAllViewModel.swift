//
//  File.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 19/05/22.
//

import Foundation

class SeeAllViewModel: ObservableObject {
    @Published var viewTitle: String = ""
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    private var apiUrl: String
    @Published var pageIndex: Int = 0
    
    init(apiUrl: String, viewTitle: String) {
        self.viewTitle = viewTitle
        self.apiUrl = apiUrl
    }
    
    func loadData() {
        self.isLoading = true
        let task = TaskManager(urlString: self.apiUrl, method: .GET, parameters: nil)
        task.execute { result, content, data in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if result {
                do {
                    let decoder = JSONDecoder()
                    let identity = try decoder.decode([Product].self, from: data!)
                    DispatchQueue.main.async {
                        self.products = identity
                    }
                } catch {
                    var errorStr = NSLocalizedString("Unable to parse the received content", comment: "Unable to convert data")
                    do {
                        let error = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                        if let e = error {
                            if let d = e["exception"] as? String {
                                errorStr = d
                            }
                        }
                    } catch {}
                    DispatchQueue.main.async {
                        AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: errorStr)
                    }
                    
                }
            } else {
                DispatchQueue.main.async {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: content ?? NSLocalizedString("Unknown error", comment: "Unknown error"))
                }
                
            }
        }
    }
    
    func loadNewPage(newPage :Int) {
        self.isLoading = true
        pageIndex = newPage
        let task = TaskManager(urlString: self.apiUrl.prefix(self.apiUrl.count - 1) + "\(self.pageIndex)", method: .GET, parameters: nil)
        task.execute { result, content, data in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if result {
                do {
                    let decoder = JSONDecoder()
                    let identity = try decoder.decode([Product].self, from: data!)
                    DispatchQueue.main.async {
                        self.products = identity
                    }
                } catch {
                    var errorStr = NSLocalizedString("Unable to parse the received content", comment: "Unable to convert data")
                    do {
                        let error = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                        if let e = error {
                            if let d = e["exception"] as? String {
                                errorStr = d
                            }
                        }
                    } catch {}
                    DispatchQueue.main.async {
                        AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: errorStr)
                    }
                    
                }
            } else {
                DispatchQueue.main.async {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: content ?? NSLocalizedString("Unknown error", comment: "Unknown error"))
                }
                
            }
        }
    }
}