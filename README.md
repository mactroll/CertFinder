#  Cert Finder

A sample app to quickly show how to find certs that may be exposed via persistent tokens on iOS.

The biggest item to note is the addition of "com.apple.token" as a keychain group. Note that Xcode will erroniously add your developer ID to the keychain group name in the app's Entitlements file, so you'll need to manually remove this.

After that, using certs is just the normal SecKeychain code.

## Acknowlegements:

This code includes ASN1Decoder for making the certs look pretty.

https://github.com/filom/ASN1Decoder
