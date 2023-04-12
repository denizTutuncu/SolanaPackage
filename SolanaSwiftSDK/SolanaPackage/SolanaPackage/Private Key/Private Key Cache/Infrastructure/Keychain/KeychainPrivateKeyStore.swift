import Foundation
import Security

public final class KeychainPrivateKeyStore {
    
    public init(network: String) {
        self.network = network
    }
    
    enum StoreError: Swift.Error {
        case insertFailed
        case errSecSuccess(String)
        case unexpectedPrivateKeyData
        case publicKeyIsAlreadyExist
    }
    
    private let network: String
}

extension KeychainPrivateKeyStore: PrivateKeyStore {
    public func deletePrivateKey(for publicKey: PublicKey) throws {
        let deleteQuery : [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: network,
            kSecAttrAccount as String: publicKey
        ]
        
        switch SecItemDelete(deleteQuery as CFDictionary) {
        case errSecItemNotFound, errSecSuccess: break // Okay to ignore
        case let status:
            throw StoreError.errSecSuccess(status.description)
        }
    }
    
    public func insert(publicKey: PublicKey, privateKey: PrivateKey) throws {
        try publicKeyExists(publicKey: publicKey)
        
        let passwordData = privateKey.data(using: String.Encoding.utf8)!
        
        let queryToAdd: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked,
            kSecAttrServer as String: network,
            kSecAttrAccount as String: publicKey,
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemAdd(queryToAdd as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            throw StoreError.insertFailed
        }
    }
    
    public func privateKey(for publicKey: PublicKey) throws -> PrivateKey? {
        let searchQuery: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                          kSecAttrServer as String: network,
                                          kSecAttrAccount as String: publicKey,
                                          kSecMatchLimit as String: kSecMatchLimitOne,
                                          kSecReturnAttributes as String: true,
                                          kSecReturnData as String: true]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(searchQuery as CFDictionary, &item)
        
        guard status != errSecItemNotFound else { return nil }        
        guard status == errSecSuccess else { throw StoreError.errSecSuccess(status.description) }
        
        
        guard let existingItem = item as? [String : Any],
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: String.Encoding.utf8),
              let _ = existingItem[kSecAttrAccount as String] as? String
        else {
            throw StoreError.unexpectedPrivateKeyData
        }
        return password
    }
    
    private func publicKeyExists(publicKey: PublicKey) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: network,
            kSecAttrAccount as String: publicKey,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            throw StoreError.publicKeyIsAlreadyExist
        } else if status != errSecItemNotFound {
            throw StoreError.errSecSuccess(status.description)
        }
    }
    
}
