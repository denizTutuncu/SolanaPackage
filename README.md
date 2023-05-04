# Solana Swift SDK 

## Solana Package Framework & Solana Package UI Framework & TREA iOS App
#### The Solana Swift SDK is a collection of Swift modules that enables developers to interact with the Solana Blockchain in their iOS, macOS, tvOS, and watchOS apps. The SDK contains two main modules:

#### Core Module:
This module contains the core models required to interact with the Solana Blockchain, with a networking layer that communicates with the blockchain and a data persistent layer that uses Core Data for domain models and Keychain for critical information such as private key and wallet details. These models include Wallet, Balance and Transaction models. The Core module provides functionalities like creating a wallet, querying balance, and sending/receiving SOL via the networking layer, while utilizing Core Data to persist domain models and Keychain to securely store critical information.

Additionally, Presentation modules support localization for four different languages: English, Portuguese, Greek, and Turkish. However, these modules are designed to be easily extensible, allowing new languages to be added with ease. This enables a wider range of users to interact with the Solana Blockchain using this module in their preferred language.

#### UI Module: 
This module is an iOS SwiftUI module that provides a set of components to build user interfaces for interacting with the Solana Blockchain. These components include views for displaying wallet details such as balance and transaction history, forms for sending and receiving SOL, and more. The UI module is designed to be easily integrated into existing iOS apps. Furthermore, this module can also be moved into a macOS framework, which can be easily integrated into existing iOS, macOS, tvOS, and watchOS apps.

#### App:

The SDK also includes an iOS app called TREA that demonstrates how to use the Core and UI modules to interact with the Solana Blockchain. The app showcases the functionalities of creating a wallet, sending/receiving SOL, viewing transaction history, and more.

TREA, Trusted Repository for Electronic Assets, to create your crypto wallet with top-tier security. This app is protected by industry-standard encryption, ensuring a secure connection with Solana.

The SDK is written in Swift and is intended to be used in Swift apps.

The SDK is open-source and hosted on Github, developers can use the SDK to build their own decentralized apps (dApps) on Solana Blockchain. Contributions are always welcome.

----------------
 
## iOS App Flow

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Diagrams/iOSAppFlow.jpg?raw=true)

```
1- Create Wallet & Receive Sol (in progress)
2- Display balance (under maintenance)
3- Display past transactions (in progress)
4- Send Sol (in the future)
```

----------------

### Prototype

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/PROTOTYPEIOS_AdobeCreativeCloudExpress.gif)

----------------

### Architecture

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Diagrams/architecture.drawio.png?raw=true)

----------------

### TREA iOS App Design

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Diagrams/iOSSDKDesign.drawio.png?raw=true)

----------------

## Create Wallet BDD Specs (in progress)

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

### Core Model
#### Seed
| Property      | Type                |
|---------------|---------------------|
| `seed`        | `[String]`          |


#### Wallet
| Property      | Type                  |
|---------------|-----------------------|
| `id`          | `String`              |
| `publicKey`   | `String`              |
| `balance`     | `String`              |

### UI Model
#### Seed
| Property      | Type                |
|---------------|---------------------|
| `seed`        | `[String]`          |

#### Wallet UI Model
| Property      | Type                  |
|---------------|-----------------------|
| `wallet`      | `Wallet`              |
| `error`       | `Error`               |
| `isLoading`   | `Bool`                |


![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/CreationOptions.jpg?raw=true)

----------------

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/SeedListGIF_AdobeExpress.gif?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/SeedListScreen.jpg?raw=true)

----------------

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/WalletViewGIF_AdobeExpress.gif?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/WalletScreen.jpg?raw=true)

----------------

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/WalletListGIF_AdobeExpress.gif?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/WalletListScreen.jpg?raw=true)

----------------

## Get Balance BDD Specs (Under Maintenance)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/WalletBalanceView.jpg?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/BalanceView.jpg?raw=true)

To show a valid public Solana address balance, first you need to create a `RemoteBalanceLoader` with a network setting, chosen valid public address and a client. Then pass it to create `BalanceComposerView`. That's it!

```
!!! Not available !!!
let remoteBalanceLoader = RemoteBalanceLoader(url: URL(string: SolanaClusterRPCEndpoints.devNet.rawValue),
                                                  publicAddress: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                                                  client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))
BalanceComposerView(viewModel:  BalanceViewModel(remoteBalanceLoader: remoteBalanceLoader))
```

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
| `amount`    | `Double`                |


### UI Model
#### Balance UI Model
| Property      | Type                  |
|---------------|-----------------------|
| `balance`     | `String`              |
| `error`       | `Error`               |
| `isLoading`   | `Bool`                |



## Display Past Transactions BDD Specs (in progress)

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/TransactionListGIF_AdobeExpress.gif?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/TXAPI.jpg?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/TXsScreen.jpg?raw=true)

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

## Model Specs

### API Response
     ... Working on the specs       

### Core Model
#### Transaction
| Property      | Type                  |
|---------------|-----------------------|
| `date`        | `String`              |
| `from`        | `String`              |
| `to`          | `String`              |
| `amount`      | `String`              |
| `currencyName`| `String`              |
| `txSignature` | `String`              |

### UI Model
#### Transaction UI Model
| Property      | Type                  |
|---------------|-----------------------|
| `tx`          | `Transaction`         |
| `error`       | `Error`               |
| `isLoading`   | `Bool`                |

-----------------

## Contribution

Contributions are always welcome.

GitHub Actions script is set up to automate the build and testing process of the project when changes are made to specific branches. The script specifies that the build-and-test job should run when a push and/or a pull request event occurs on the `main` branch.

Developers should first clone the project and then create a new development branch to make changes. Pushing changes to the development branch and opening a pull request `PR` onto `main` will trigger GitHub Actions.

The script runs two separate Xcode commands to build and test the project on macOS and iOS. The steps include checking out the code, selecting the appropriate version of Xcode, and specifying the build and test settings for each platform. The code is built using the "CI_macOS" and "CI_iOS" schemes, and tests are run with specific destination settings.
