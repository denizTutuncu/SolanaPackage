# Solana Swift SDK 
## Solana Package Framework & Solana Package UI Framework & MySolWallet iOS App
#### The Solana Swift SDK is a collection of Swift modules that enables developers to interact with the Solana Blockchain in their iOS, macOS, tvOS, and watchOS apps. The SDK contains two main modules:

#### Core Module:
This module contains the core models required to interact with the Solana Blockchain. These models include Balance, Wallet, and Transaction models. The Core module provides functionalities like creating a wallet, querying balance, and sending/receiving SOL.

#### UI Module: 
This module is a platform-independent SwiftUI module that provides a set of components to build user interfaces for interacting with the Solana Blockchain. These components include views for displaying balance and transaction history, forms for sending and receiving SOL, and more. The UI module is designed to be easily integrated into existing iOS, macOS, tvOS, and watchOS apps.

----------------

The SDK also includes an iOS app called MySolWallet that demonstrates how to use the Core and UI modules to interact with the Solana Blockchain. The app showcases the functionalities of creating a wallet, sending/receiving SOL, viewing transaction history, and more.

The SDK is written in Swift and is intended to be used in Swift apps.

The SDK is open-source and hosted on Github, developers can use the SDK to build their own decentralized apps (dApps) on Solana Blockchain. Contributions are always welcome.

----------------
 
## iOS App Flow
![alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Diagrams/iOSAppFlow.jpg?raw=true)

```
1- Create Wallet & Receive Sol (in the future)
2- Display balance (in progress, component is ready to review)
3- Display past transactions (in progress)
4- Send Sol (in the future)
```

----------------

### Core Modules
![alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Diagrams/SolanaSwiftSDK.jpg?raw=true)

----------------

### Prototype
![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Diagrams/PROTOTYPEIOS_AdobeCreativeCloudExpress.gif)

----------------

### My Sol Wallet iOS App Design
![alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Diagrams/iOSSDKDesign?raw=true)

----------------

## Create Wallet BDD Specs (in the future)

### Create Wallet / Receive Sol
### Story: Customer requests to create a solana wallet

### Narrative #1
```
As a customer
I want the app to create a solana wallet
So I can connect to Solana Blockchain
```

#### Scenarios (Acceptance criteria)

```
Given the customer has seed phrase
When the customer requests to create a solana wallet
Then the app should display the seed phrase
And create a solana wallet from that seed phrase
```

#### Scenarios (Acceptance criteria)

```
Given the customer doesn't have a seed phrase
   Then the app should display an error message
Given the customer have a seed phrase
    And the seed phrase is valid
        Then the app should create a valid Solana account
```

## Model Specs

### Seed

| Property      | Type                |
|---------------|---------------------|
| `seed`        | `[String]`          |


----------------

## Get Balance BDD Specs (Under Maintenance)
To show a valid public Solana address balance, first you need to create a `RemoteBalanceLoader` with a network setting, chosen valid public address and a client. Then pass it to create `BalanceComposerView`. That's it!

```
!!! Not available !!!
let remoteBalanceLoader = RemoteBalanceLoader(url: URL(string: SolanaClusterRPCEndpoints.devNet.rawValue),
                                                  publicAddress: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                                                  client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))
BalanceComposerView(viewModel:  BalanceViewModel(remoteBalanceLoader: remoteBalanceLoader))
```

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaiOS/Diagrams/BalanceAPI.gif)
### Get Balance
### Story: Customer requests to see their balance

### Narrative #1
```
As an online customer
I want the app to automatically load my latest balance
So I can see my balance
```
#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
  And a valid public Solana address
  When the customer requests to see their balance
  Then the app should display the latest balance from remote
  And replace the cache with the balance
```

### Narrative #2

```
As an offline customer
I want the app to show the latest saved version of my balance
So I can always see my balance
```

#### Scenarios (Acceptance criteria)

```
Given the customer doesn't have connectivity
  And there’s a cached version of the balance
  And the cache is less than seven days old
  When the customer requests to see the balance
  Then the app should display the latest balance saved
Given the customer doesn't have connectivity
  And there’s a cached version of the feed
  And the cache is seven days old or more
  When the customer requests to see the balance
  Then the app should display an error message
Given the customer doesn't have connectivity
  And the cache is empty
  When the customer requests to see the balance
  Then the app should display an error message
Given the customer doesn't a valid public Solana address
  Then the app should display an error message
```

## Model Specs


### API Response
#### Root
| Property      | Type                  |
|---------------|-----------------------|
| `jsonrpc`     | `String`              |
| `result`      | `RemoteBalanceResult` |
| `id`          | `String`              |

#### Remote Balance Result
| Property      | Type                  |
|---------------|-----------------------|
| `context`     | `RemoteBalanceContext`|
| `value`       | `Int`                 |
| `id`          | `String`              |

#### Remote Balance Context
| Property      | Type                  |
|---------------|-----------------------|
| `slot`        | `Int`                 |



### Core Model
#### Balance
| Property      | Type                  |
|---------------|-----------------------|
| `lamports`    | `Int`                 |



### UI Model
#### Balance UI Model
| Property      | Type                  |
|---------------|-----------------------|
| `balance`     | `String`              |
| `error`       | `Error`               |
| `isLoading`   | `Bool`                |



## Display Past Transactions BDD Specs (in progress)

### Display Past Transactions
### Story: Customer requests to review their past transacations

### Narrative #1
```
As a customer
I want the app to show my past transactions
So I can review them
```

#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
  And a valid public Solana address 
  When the customer requests to see their past transactions
  Then the app should display past transactions from remote
  And replace the cache with the past transactions
```

-----------------

Still working on the specs. Thank you for your understanding and please feel free to conncet with me and/or contribute to the project.