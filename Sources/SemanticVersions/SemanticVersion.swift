@frozen public 
struct SemanticVersion:Sendable 
{
    public 
    var major:UInt16 
    public 
    var minor:UInt16 
    public 
    var patch:UInt16 

    @inlinable public 
    init(_ major:UInt16, _ minor:UInt16, _ patch:UInt16)
    {
        self.major = major 
        self.minor = minor 
        self.patch = patch 
    }
}
extension SemanticVersion:LosslessStringConvertible, CustomStringConvertible
{
    @inlinable public
    init?(_ string:String)
    {
        let components:[Substring] = string.split(separator: ".", maxSplits: 3,
            omittingEmptySubsequences: false)
        if  components.count == 3,
            let major:UInt16 = .init(components[0]),
            let minor:UInt16 = .init(components[1]),
            let patch:UInt16 = .init(components[2])
        {
            self.init(major, minor, patch)
        }
        else
        {
            return nil
        }
    }

    @inlinable public
    var description:String
    {
        "\(self.major).\(self.minor).\(self.patch)"
    }
}
extension SemanticVersion:Hashable, Comparable
{
    @inlinable public static 
    func < (lhs:Self, rhs:Self) -> Bool 
    {
        (lhs.major, lhs.minor, lhs.patch) < (rhs.major, rhs.minor, rhs.patch)
    }
}
