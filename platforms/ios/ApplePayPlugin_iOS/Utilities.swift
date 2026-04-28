import Foundation

public typealias CStringPtr = UnsafePointer<CChar>

public typealias VoidDelegate = @convention(c) () -> Void;
public typealias StringDelegate = @convention(c) (CStringPtr) -> Void;
public typealias IntDelegate = @convention(c) (Int32) -> Void;
public typealias LongDelegate = @convention(c) (Int64) -> Void;
public typealias FloatDelegate = @convention(c) (Float) -> Void;
public typealias BoolDelegate = @convention(c) (Bool) -> Void;

public typealias BoolStringDelegate = @convention(c) (Bool, CStringPtr) -> Void;

extension UnsafePointer where Pointee == CChar {
    func toString() -> String { String(cString: self) }
}

public final class JsonConvert {

    private static let sharedEncoder = JSONEncoder()
    private static let sharedDecoder = JSONDecoder()

    public static func serializeObject<T: Encodable>(_ value: T) throws -> String {
        let data = try sharedEncoder.encode(value)
        guard let json = String(data: data, encoding: .utf8) else {
            throw NSError(
                domain: "JsonConvert", code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to encode JSON string"])
        }
        return json
    }

    public static func deserializeObject<T: Decodable>(_ jsonData: Data?, as type: T.Type) throws -> T {
        guard let data = jsonData else {
            throw NSError(domain: "JsonConvert", code: 3, userInfo: [NSLocalizedDescriptionKey: "Missing data"])
        }
        return try sharedDecoder.decode(T.self, from: data)
    }
    public static func deserializeObject<T: Decodable>(_ json: String, as type: T.Type) throws -> T {
        guard let data = json.data(using: .utf8) else {
            throw NSError(
                domain: "JsonConvert", code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Invalid UTF-8 string: \(json)"])
        }
        return try sharedDecoder.decode(T.self, from: data)
    }
}
