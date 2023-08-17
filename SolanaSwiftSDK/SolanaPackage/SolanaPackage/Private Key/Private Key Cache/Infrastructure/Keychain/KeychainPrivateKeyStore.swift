import Foundation
import Security

public final class KeychainPrivateKeyStore {
    
    public init() {}
    
    enum StoreError: Swift.Error {
        case insertFailed
        case deleteStatus(String)
        case read(String)
    }
}

extension KeychainPrivateKeyStore: PrivateKeyStore {
    public func deleteKey(for publicKey: PublicKey) throws {
        let deleteQuery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccessible: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
            kSecUseDataProtectionKeychain: true,
            kSecAttrAccount: publicKey
        ] as [String: Any]
        switch SecItemDelete(deleteQuery as CFDictionary) {
        case errSecItemNotFound, errSecSuccess: break
        case let status:
            throw StoreError.deleteStatus(status.description)
        }
    }
    
    public func store(publicKey: PublicKey, privateKey: PrivateKey) throws {
        let passwordData = privateKey.data(using: .utf8)!
        
        let queryToAdd = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccessible: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
            kSecUseDataProtectionKeychain: true,
            kSecAttrAccount: publicKey,
            kSecValueData: passwordData
        ] as [String: Any]
        
        let status = SecItemAdd(queryToAdd as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            throw StoreError.insertFailed
        }
    }
    
    public func read(for publicKey: PublicKey) throws -> PrivateKey? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccessible: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
            kSecUseDataProtectionKeychain: true,
            kSecAttrAccount: publicKey,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as [String: Any]
        
        var item: CFTypeRef?
        
        switch SecItemCopyMatching(query as CFDictionary, &item) {
        case errSecSuccess:
            guard let existingItem = item as? [String: Any],
                  let passwordData = existingItem[kSecValueData as String] as? Data else {
                return nil
            }
            return String(data: passwordData, encoding: .utf8)
        case errSecItemNotFound:
            return nil
        case let status:
            throw StoreError.read(status.description)
        }
    }

}
