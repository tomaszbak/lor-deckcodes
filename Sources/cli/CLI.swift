import LoRDeckCodes
import ArgumentParser

struct CLI: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "lor-deckcodes")
    
    @Argument(help: "Deck code in Base32 format")
    var code: String
    
    func run() throws {
        do {
            try Decoder()
                .decode(code).cards
                .forEach {
                    print($0.description)
                }
        } catch is Base32DecodingError {
            throw CLIError(description: "Base32 decoding have failed")
        } catch DecodingError.invalidFormat(let format, let version) {
            throw CLIError(description: "Deck code with format: \(format) v\(version) is not supported")
        } catch is DecodingError {
            throw CLIError(description: "Deck code data is corrupted")
        } catch {
            throw CLIError(description: "Unknown")
        }
    }
}

private struct CLIError: Error, CustomStringConvertible {
    var description: String
}
