/// A mangled symbol identifier, like `ss17FloatingPointSignO`. Symbol
/// identifiers don’t contain colons.
@frozen public
struct SymbolIdentifier:RawRepresentable, Sendable
{
    public 
    let rawValue:String 
    
    @inlinable public 
    init(rawValue:String)
    {
        self.rawValue = rawValue
    }
}
extension SymbolIdentifier
{
    /// Creates a symbol identifier from the given language prefix and
    /// mangled suffix. This initializer does not validate the suffix.
    @inlinable public 
    init(_ language:Language, ascii suffix:some StringProtocol)
    {
        self.init(rawValue: "\(language.rawValue)\(suffix)")
    }
    /// Creates a symbol identifier from the given language prefix and
    /// mangled suffix, returning nil if the suffix contains characters
    /// that are not allowed to appear in a symbol identifier.
    ///
    /// Valid characters are `_`, `[A-Z]`, `[a-z]`, `[0-9]`, and `@`.
    @inlinable public 
    init?(_ language:Language, _ suffix:some StringProtocol)
    {
        for ascii:UInt8 in suffix.utf8
        {
            switch ascii
            {
            //    '_'   'A' ... 'Z'    'a' ... 'z'    '0' ... '9',   '@'
            case 0x5f, 0x41 ... 0x5a, 0x61 ... 0x7a, 0x30 ... 0x39, 0x40:
                continue
            default: 
                return nil
            }
        }
        self.init(language, ascii: suffix)
    }
    
    @inlinable public 
    var language:Language?
    {
        self.rawValue.unicodeScalars.first.flatMap(Language.init(rawValue:))
    }
}
extension SymbolIdentifier:Equatable
{
    @inlinable public static
    func == (lhs:Self, rhs:Self) -> Bool 
    {
        lhs.rawValue.utf8.elementsEqual(rhs.rawValue.utf8)
    }
}
extension SymbolIdentifier:Hashable 
{
    @inlinable public 
    func hash(into hasher:inout Hasher) 
    {
        for byte:UInt8 in self.rawValue.utf8
        {
            byte.hash(into: &hasher)
        }
    }
}
extension SymbolIdentifier:Comparable
{
    @inlinable public static
    func < (lhs:Self, rhs:Self) -> Bool 
    {
        lhs.rawValue.utf8.lexicographicallyPrecedes(rhs.rawValue.utf8)
    }
}
extension SymbolIdentifier:CustomStringConvertible
{
    @inlinable public
    var description:String
    {
        self.rawValue
    }
}
