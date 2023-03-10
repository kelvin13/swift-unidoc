import SymbolResolution
import Symbols
import Testing

@main
enum Main:SyncTests
{
    static
    func run(tests:Tests)
    {
        if  let tests:TestGroup = tests / "empty"
        {
            tests.expect(nil: UnifiedSymbolResolution.init(rawValue: ""))
        }
        if  let tests:TestGroup = tests / "empty-suffix"
        {
            tests.expect(nil: UnifiedSymbolResolution.init(rawValue: "s:"))
        }

        if  let tests:TestGroup = tests / "scalar"
        {
            if  let usr:UnifiedSymbolResolution = tests.expect(value: .init(
                    rawValue: "s:s12IdentifiableP"))
            {
                tests.expect(usr ==? .scalar(.init(.init("s", ascii: "s12IdentifiableP"))))
            }
        }
        if  let tests:TestGroup = tests / "scalar" / "unicode"
        {
            if  let usr:UnifiedSymbolResolution = tests.expect(value: .init(
                    rawValue: "♥:s12IdentifiableP"))
            {
                tests.expect(usr ==? .scalar(.init(.init("♥", ascii: "s12IdentifiableP"))))
            }
        }
        if  let tests:TestGroup = tests / "scalar" / "invalid-language"
        {
            tests.expect(nil: UnifiedSymbolResolution.init(
                    rawValue: "ss:s12IdentifiableP"))
        }
        if  let tests:TestGroup = tests / "scalar" / "invalid-characters"
        {
            tests.expect(nil: UnifiedSymbolResolution.init(
                    rawValue: "s:s12Identifi-ableP"))
        }

        if  let tests:TestGroup = tests / "compound"
        {
            if  let usr:UnifiedSymbolResolution = tests.expect(value: .init(
                    rawValue: "s:s12IdentifiablePsRlzCrlE2idSOvp::SYNTHESIZED::s:Sq"))
            {
                tests.expect(usr ==? 
                    .compound(.init(.init("s", ascii: "s12IdentifiablePsRlzCrlE2idSOvp")),
                        self: .init(.init("s", ascii: "Sq"))))
            }
        }
        if  let tests:TestGroup = tests / "compound" / "invalid-prefix"
        {
            tests.expect(nil: UnifiedSymbolResolution.init(
                    rawValue: ":s12IdentifiablePsRlzCrlE2idSOvp::SYNTHESIZED::s:Sq"))
        }
        if  let tests:TestGroup = tests / "compound" / "invalid-infix"
        {
            tests.expect(nil: UnifiedSymbolResolution.init(
                    rawValue: "s:s12IdentifiablePsRlzCrlE2idSOvp::LASERTITTIES::s:Sq"))
        }
        if  let tests:TestGroup = tests / "compound" / "invalid-suffix"
        {
            tests.expect(nil: UnifiedSymbolResolution.init(
                    rawValue: "s:s12IdentifiablePsRlzCrlE2idSOvp::SYNTHESIZED::s:"))
        }

        if  let tests:TestGroup = tests / "block" / "first-member"
        {
            if  let usr:UnifiedSymbolResolution = tests.expect(value: .init(
                    rawValue: "s:e:s:Sq17ZooExtensionsDeepSiRszlE2ids5NeverOvp"))
            {
                tests.expect(usr ==? .block("s:Sq17ZooExtensionsDeepSiRszlE2ids5NeverOvp"))
            }
        }
        if  let tests:TestGroup = tests / "block" / "first-conformance"
        {
            if  let usr:UnifiedSymbolResolution = tests.expect(value: .init(
                    rawValue: "s:e:s:Sqs:s8SendableP"))
            {
                tests.expect(usr ==? .block("s:Sqs:s8SendableP"))
            }
        }
        if  let tests:TestGroup = tests / "block" / "gibberish"
        {
            if  let usr:UnifiedSymbolResolution = tests.expect(value: .init(
                    rawValue: "s:e: \n!\u{0} 🇺🇸"))
            {
                tests.expect(usr ==? .block(" \n!\u{0} 🇺🇸"))
            }
        }
        if  let tests:TestGroup = tests / "block" / "empty"
        {
            if  let usr:UnifiedSymbolResolution = tests.expect(value: .init(
                    rawValue: "s:e:"))
            {
                tests.expect(usr ==? .block(""))
            }
        }
    }
}
