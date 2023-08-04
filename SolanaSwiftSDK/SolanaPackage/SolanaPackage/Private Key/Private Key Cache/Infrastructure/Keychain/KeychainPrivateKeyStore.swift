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
        let passwordData = privateKey.data(using: String.Encoding.utf8)!
        
        let queryToAdd = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: publicKey,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
            kSecUseDataProtectionKeychain: true,
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
            kSecAttrAccount: publicKey,
            kSecUseDataProtectionKeychain: true,
            kSecReturnData: true
        ] as [String: Any]
        
        var item: CFTypeRef?
        
        switch SecItemCopyMatching(query as CFDictionary, &item) {
        case errSecSuccess:
            guard let existingItem = item as? [String : Any],
                  let passwordData = existingItem[kSecValueData as String] as? Data,
                  let password = String(data: passwordData, encoding: String.Encoding.utf8) else { return nil }
            return password
        case errSecItemNotFound: return nil
        case let status:  throw StoreError.read(status.description)
        }
    }
    
}
