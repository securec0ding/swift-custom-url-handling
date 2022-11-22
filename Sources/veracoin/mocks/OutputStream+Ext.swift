//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//

import Foundation

extension OutputStream {

    func write(_ string: String, encoding: String.Encoding = .utf8, allowLossyConversion: Bool = false) -> Int {

        if let data = string.data(using: encoding, allowLossyConversion: allowLossyConversion) {
            return data.withUnsafeBytes { ptr -> Int in
                guard let bytes = ptr.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                    return -1
                }
                var pointer = bytes
                var bytesRemaining = data.count
                var totalBytesWritten = 0

                while bytesRemaining > 0 {
                    let bytesWritten = self.write(pointer, maxLength: bytesRemaining)
                    if bytesWritten < 0 {
                        return -1
                    }

                    bytesRemaining -= bytesWritten
                    pointer += bytesWritten
                    totalBytesWritten += bytesWritten
                }

                return totalBytesWritten
            }
        }

        return -1
    }

}