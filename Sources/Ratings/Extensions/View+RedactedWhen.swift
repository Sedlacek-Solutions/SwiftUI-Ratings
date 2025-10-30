import SwiftUI

extension View {
    /// Applies redaction to a view based on a conditional statement.
    ///
    /// This modifier provides a more convenient way to conditionally redact content
    /// compared to the standard redacted modifier which requires separate view branches.
    ///
    /// - Parameters:
    ///   - reason: The redaction reason to apply when the condition is true (default is `.placeholder`).
    ///   - condition: A Boolean value that determines whether redaction should be applied.
    /// - Returns: A view that is redacted when the condition is true.
    func redacted(
        reason: RedactionReasons = .placeholder,
        when condition: Bool
    ) -> some View {
        redacted(reason: condition ? reason : [])
    }
}
