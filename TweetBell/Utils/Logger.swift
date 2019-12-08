import Foundation

final class Logger {
  
  func debug(_ message: Any, file: String = #file, line: Int = #line) {
    print("✅ Debug - \(file.split(separator: "/").last!):\(line) => \(message)")
  }
  
  func error(_ message: Any, file: String = #file, line: Int = #line) {
    print("❌ Error - \(file.split(separator: "/").last!):\(line) => \(message)")
  }
}

