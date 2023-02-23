//
//  KeychainWalletStore.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import Foundation

public final class KeychainWalletStore {
    private struct CodableWallet: Codable {
        let id: UUID
        let publicKey: String
        let privateKey: String
        let balance: Double
        
        
        init(wallet: LocalWallet) {
            self.id = wallet.id
            self.publicKey = wallet.publicKey
            self.privateKey = wallet.privateKey
            self.balance = wallet.balance
        }
    }
    enum Error: Swift.Error {
        case invalidData
        case saveFailed
        case deleteFailed
        case decodeFailed
    }
    
    private let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    private static func map(_ wallet: CodableWallet) throws -> LocalWallet {
        guard wallet.balance >= 0.0 else { throw Error.invalidData }
        return  LocalWallet(id: wallet.id, publicKey: wallet.publicKey, privateKey: wallet.privateKey, balance: wallet.balance)
    }
    
    private static func map(localwallet: LocalWallet) throws -> CodableWallet {
        guard localwallet.balance >= 0.0 else { throw Error.invalidData }
        return CodableWallet(wallet: localwallet)
    }
    
}

extension KeychainWalletStore: WalletStore {
    //MARK: - THIS DOESNT FEEL SAFE! How to delete specific wallet
    public func deleteCachedWallet() throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        
        guard SecItemDelete(query) == noErr else {
            throw Error.deleteFailed
        }
    }
    
    public func insert(_ wallet: [LocalWallet], timestamp: Date) throws {
        do {
            //MARK: - BANG ! 
            let localWallet = try KeychainWalletStore.map(localwallet: wallet.first!)
            let data = try JSONEncoder().encode(localWallet)
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: data
            ] as CFDictionary
            
            guard SecItemDelete(query) == noErr else {
                throw Error.deleteFailed
            }
            
            guard SecItemAdd(query, nil) == noErr else {
                throw Error.saveFailed
            }
        }
    }
    
    public func retrieve() throws -> CachedWallet? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        guard status == noErr, let data = result as? Data else {
            throw Error.invalidData
        }
        
        guard !data.isEmpty else { return nil }
        
        do {
            let wallet = try JSONDecoder().decode(CodableWallet.self, from: data)
            let localWallet = try KeychainWalletStore.map(wallet)
            
            return CachedWallet(wallet: [localWallet], timestamp: Date())
        } catch {
            throw Error.decodeFailed
        }
        
    }
}
