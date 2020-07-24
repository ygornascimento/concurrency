import UIKit

for i in 1...10 {
    guard i.isMultiple(of: 3) else {
        continue
    }

    print(i)
}
