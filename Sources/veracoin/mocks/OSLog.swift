//
//  OSLog.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock OSLog
// 

import Foundation

public struct OSLogType : Equatable, RawRepresentable {
    public init(_ rawValue: UInt8) {
        self.rawValue = rawValue
    }

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

    public var rawValue: UInt8
}

extension OSLogType {

    public static let `default` = OSLogType(0)

    public static let info = OSLogType(1)

    public static let debug = OSLogType(2)

    public static let notice = OSLogType(3)

    public static let error = OSLogType(4)

    public static let fault = OSLogType(5)
}

open class OSLog  {
    private let _subsystem:String
    private let _category:String

    private init(_subsystem: String, _category: String) {
        self._subsystem = _subsystem
        self._category = _category
    }
}

extension OSLog {

    public struct Category {

        public let rawValue: String

        //public static let pointsOfInterest: OSLog.Category
    }

    public convenience init(subsystem: String, category: OSLog.Category) {
        self.init(_subsystem: subsystem, _category: category.rawValue)
    }
}

extension OSLog {

    public static let disabled = OSLog(subsystem:"_disabled", category:"_disabled")

    public static let `default` = OSLog(subsystem:"_default", category:"_default")

    public convenience init(subsystem: String, category: String) {
        self.init(_subsystem: subsystem, _category: category)
    }
}

public struct OSLogPrivacy: Equatable {
    public var rawValue: UInt8

    public init(_ rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    /// Sets the privacy level of an interpolated value to public.
    ///
    /// When the privacy level is public, the value will be displayed
    /// normally without any redaction in the logs.
    public static var `public` = OSLogPrivacy(1)

    /// Sets the privacy level of an interpolated value to private.
    ///
    /// When the privacy level is private, the value will be redacted in the logs,
    /// subject to the privacy configuration of the logging system.
    public static var `private` = OSLogPrivacy(2)

    /// Sets the privacy level of an interpolated value to sensitive.
    ///
    /// When the privacy level is sensitive, the value will be redacted in the logs,
    /// subject to the privacy configuration of the logging system.
    public static var sensitive = OSLogPrivacy(3)

    /// Auto-infers a privacy level for an interpolated value.
    ///
    /// The system will automatically decide whether the value should
    /// be captured fully in the logs or should be redacted.
    public static var auto = OSLogPrivacy(4)
}

public struct OSLogInterpolation : StringInterpolationProtocol {
    var value = ""

    /// Creates an empty instance ready to be filled with string literal content.
    /// 
    /// Don't call this initializer directly. Instead, initialize a variable or
    /// constant using a string literal with interpolated expressions.
    /// 
    /// Swift passes this initializer a pair of arguments specifying the size of
    /// the literal segments and the number of interpolated segments. Use this
    /// information to estimate the amount of storage you will need.
    /// 
    /// - Parameter literalCapacity: The approximate size of all literal segments
    ///   combined. This is meant to be passed to `String.reserveCapacity(_:)`;
    ///   it may be slightly larger or smaller than the sum of the counts of each
    ///   literal segment.
    /// - Parameter interpolationCount: The number of interpolations which will be
    ///   appended. Use this value to estimate how much additional capacity will
    ///   be needed for the interpolated segments.
    public init(literalCapacity: Int, interpolationCount: Int)
    {

    }

    /// Appends a literal segment to the interpolation.
    /// 
    /// Don't call this method directly. Instead, initialize a variable or
    /// constant using a string literal with interpolated expressions.
    /// 
    /// Interpolated expressions don't pass through this method; instead, Swift
    /// selects an overload of `appendInterpolation`. For more information, see
    /// the top-level `StringInterpolationProtocol` documentation.
    /// 
    /// - Parameter literal: A string literal containing the characters
    ///   that appear next in the string literal.
    public mutating func appendLiteral(_ literal: String) {
        self.value.append(literal)
    }

    /// The type that should be used for literal segments.
    public typealias StringLiteralType = String
}

extension OSLogInterpolation {

    /// Defines interpolation for expressions of type String.
    ///
    /// Do not call this function directly. It will be called automatically when interpolating
    /// a value of type `String` in the string interpolations passed to the log APIs.
    ///
    /// - Parameters:
    ///   - argumentString: The interpolated expression of type String, which is autoclosured.
    ///   - align: Left or right alignment with the minimum number of columns as
    ///     defined by the type `OSLogStringAlignment`.
    ///   - privacy: A privacy qualifier which is either private or public.
    ///     It is auto-inferred by default.
    public mutating func appendInterpolation(_ argumentString: @autoclosure @escaping () -> String, privacy: OSLogPrivacy = .auto)
    {  
        switch (privacy) {
            case .public:
                self.value.append(argumentString())
            default:
                self.value.append("private")
        }
    }

    public mutating func appendInterpolation(_ number: @autoclosure @escaping () -> Int, privacy: OSLogPrivacy = .auto)
    {
        switch (privacy) {
            case .private:
                self.value.append("private")
            default:
                self.value.append(String(describing:number()))
        }
    }

}

struct OSLogMessage : LosslessStringConvertible {
    var value: String

    init?(_ value: String) {
        self.value = value
    }

    var description: String {
        return self.value
    }

    /// Valid types for `StringLiteralType` are `String` and `StaticString`.
    public typealias StringLiteralType = String

    /// A type that represents an extended grapheme cluster literal.
    ///
    /// Valid types for `ExtendedGraphemeClusterLiteralType` are `Character`,
    /// `String`, and `StaticString`.
    public typealias ExtendedGraphemeClusterLiteralType = String

    /// A type that represents a Unicode scalar literal.
    ///
    /// Valid types for `UnicodeScalarLiteralType` are `Unicode.Scalar`,
    /// `Character`, `String`, and `StaticString`.
    public typealias UnicodeScalarLiteralType = String

    /// The type each segment of a string literal containing interpolations
    /// should be appended to.
    ///
    /// The `StringLiteralType` of an interpolation type must match the
    /// `StringLiteralType` of the conforming type.
    public typealias StringInterpolation = OSLogInterpolation    
}

extension OSLogMessage: ExpressibleByStringInterpolation {
  init(stringLiteral value: String) {
    self.init(value)!
  }

  init(stringInterpolation: OSLogInterpolation) {
    self.init(stringInterpolation.value)!
  }

}

func os_log(_ logLevel: OSLogType = .default, log logObject: OSLog = .default, _ message: OSLogMessage)
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    let nowString = dateFormatter.string(from: Date())

    var level = ""
    switch (logLevel) {
        case .info:
            level = "Info"
        case .debug:
            level = "Debug"
        case .error:
            level = "Error"
        case .notice:
            fallthrough
        default:
            level = "Notice"
    }

    if let ws = gWebSocket {
        ws.send("A|O|\(level) \(message)")
    }    

    let str = "\(nowString) Veracoin \(level) \(message)\n"
    let url = URL(fileURLWithPath: "log.txt")

    if let outputStream = OutputStream(url: url, append: true) {
        outputStream.open()
        let _ = outputStream.write(str)
        outputStream.close()            
    }
}

func os_log(_ message: OSLogMessage)
{
    os_log(.default, log: .default, message)
}