/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

final class TiltShiftTableViewController: UITableViewController {

  private var urls: [URL] = []
  private let context = CIContext()
  private let queue = OperationQueue()

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let urlsPlist = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
          let contents = try? Data(contentsOf: urlsPlist),
          let serial = try? PropertyListSerialization.propertyList(
            from: contents,
            format: nil  ),
          let serialUrls = serial as? [String] else {
        print("No no no no no....")
        return
    }

    urls = serialUrls.compactMap(URL.init)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "normal", for: indexPath) as! PhotoCell

//    let image = UIImage(named: "\(indexPath.row).png")! - Third Attempt

    //MARK: - Fourth Attempt
    let imageOperation = NetworkImageOperation(url: urls[indexPath.row])
    imageOperation.completionBlock = {
      DispatchQueue.main.async {
        guard let cell = tableView.cellForRow(at: indexPath) as? PhotoCell else { return }

        cell.isLoading = false
        cell.display(image: imageOperation.image)
      }
    }

    queue.addOperation(imageOperation)


    //MARK: - Third Attempt
//    let imageOperation = TiltShiftOperation(image: image)
//    imageOperation.completionBlock = {
//      DispatchQueue.main.async {
//        guard let cell = tableView.cellForRow(at: indexPath) as? PhotoCell else { return }
//
//        cell.isLoading = false
//        cell.display(image: imageOperation.outputImage)
//      }
//    }
//
//    queue.addOperation(imageOperation)

    // MARK: - Second Attempt
//    print("Filtering...")
//    let imageOperation = TiltShiftOperation(image: image)
//    imageOperation.start()
//
//    cell.display(image: imageOperation.outputImage)
//    print("Done")


    // MARK: - First Attempt
//    cell.display(image: nil)

//    let name = "\(indexPath.row).png"
//    let inputImage = UIImage(named: name)!
//
//    print("Tilt shifting image \(name)")
//
//    guard let filter = TiltShiftFilter(image: inputImage, radius: 3),
//      let output = filter.outputImage else {
//        print("Failed to generate tilt shift image")
//        cell.display(image: nil)
//
//        return cell
//    }
//
//    print("Generating UIImage for \(name)")
//    let fromRect = CGRect(origin: .zero, size: inputImage.size)
//    guard let cgImage = context.createCGImage(output, from: fromRect) else {
//      print("No image generated")
//      cell.display(image: nil)
//
//      return cell
//    }
//
//    cell.display(image: UIImage(cgImage: cgImage))
//    print("Displaying... \(name)")

    return cell
  }
}
