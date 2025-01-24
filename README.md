# Solana Swift SDK 

[![CI-macOS](https://github.com/denizTutuncu/SolanaPackage/actions/workflows/CI-macOS.yml/badge.svg?event=pull_request)](https://github.com/denizTutuncu/SolanaPackage/actions/workflows/CI-macOS.yml)

[![CI-iOS](https://github.com/denizTutuncu/SolanaPackage/actions/workflows/CI-iOS.yml/badge.svg?event=pull_request)](https://github.com/denizTutuncu/SolanaPackage/actions/workflows/CI-iOS.yml)

## Solana Package Framework & Solana Package UI Framework & Blue Giant Labs iOS App
#### 
The SolanaPackage repository includes a workspace named MySolWallet. Inside this workspace, there are two projects: Solana Package and MySolWallet projects. The Solana Package project has two framework targets: Solana Package, which contains code that works across different platforms, and SolanaPackageUI, which is specifically for iOS and includes iOS-specific code like the user interface (UI). Additionally, there are some test targets.

In this project, I use both vertical and horizontal slicing. Vertical slicing separates the features, while horizontal slicing is used for each individual feature.

#### Core Module:
This module contains the core models required to interact with any Blockchain, starting with Solana. It includes a networking layer that communicates with any blockchain and a data persistent layer that uses file-based storage for codable models such as public keys and keychain storage for critical information such as private keys. These public models currently include Public Keys but are open for extensions, such as wallet details like balance and transaction models. The Core module provides functionalities like creating a wallet (public and private key) from a seed phrase, querying balance and transactions, and receiving/sending SOL.

Additionally, Presentation modules support localization for four different languages: English, Portuguese, Greek, and Turkish. However, these modules are designed to be easily extensible, allowing new languages to be added with ease. This enables a wider range of users to interact with the Solana Blockchain using this module in their preferred language.

#### UI Module: 
This module is an iOS SwiftUI module that provides a set of components to build user interfaces for interacting with the Solana Blockchain. These components include views for displaying wallet details such as balance and transaction history, forms for sending and receiving SOL, and more. The UI module is designed to be easily integrated into existing iOS apps. Furthermore, this module can also be moved into a macOS framework, which can be easily integrated into existing iOS, macOS, tvOS, and watchOS apps.

#### App:

The repo also includes an iOS app called ```BGL``` that demonstrates how to use the Core and UI modules to interact with the Solana Blockchain. The app showcases the functionalities of creating a wallet, sending/receiving SOL, viewing transaction history, and more.

BGL, Blue Giant Labs, creates your crypto Solana wallet with top-tier security. This app is protected by industry-standard encryption, ensuring a secure connection with Solana.

The SDK is written in Swift and is intended to be used in Swift apps.

The SDK is open-source and hosted on Github, developers can use the SDK to build their own apss to connect with decentralized apps (dApps) on Solana Blockchain. Contributions are always welcome. Please find the details at the end on how to contribute.

```BGL``` is avaiable on Test Flight.

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/TreaTestFlight.jpg?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/BGLAppSS.jpg?raw=true)

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/BGL.gif?raw=true)

----------------

### Inital Prototype & Prototype's Flowchart

```
1- Create Wallet & Receive Sol (in progress)
2- Display balance (under maintenance)
3- Display past transactions (in progress)
4- Send Sol (in the future)
```

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/PROTOTYPEIOS_AdobeCreativeCloudExpress.gif)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Diagrams/iOSAppFlow.drawio.png?raw=true)

----------------
 
## iOS App Flow

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Diagrams/PrototypeFlowchart.drawio.png?raw=true)

----------------

### Architecture

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Diagrams/architecture.drawio.png?raw=true)

----------------

### Blue Giant Labs iOS App Design

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
| Property      | Type                   |
|---------------|------------------------|
| `seed`        | `[String]`             |

#### Public Key
| Property      | Type                   |
|---------------|------------------------|
| `value`       | `String`               |

#### Private Key
| Property      | Type                   |
|---------------|------------------------|
| `value`       | `String`               |

#### Balance
| Property      | Type                   |
|---------------|------------------------|
| `id`          | `String`               |
| `value`       | `String`               |

#### Transaction
| Property      | Type                   |
|---------------|------------------------|
| `id`          | `String`               |
| `date`        | `Date`                 |
| `from`        | `String`               |
| `to`          | `String`               |
| `amount`      | `String`               |
| `currencyName`| `String`               |
| `signature`   | `String`               |


#### Asset
| Property      | Type                   |
|---------------|------------------------|
| `id`          | `String`               |
| `name`        | `String`               |

#### Wallet
| Property      | Type                   |
|---------------|------------------------|
| `id`          | `String`               |
| `publicKey`   | `String`               |
| `balance`     | `String`               |

### UI View Model
#### Seed VM
| Property      | Type                   |
|---------------|------------------------|
| `seed`        | `PresentableSeed`      |
| `error`       | `Error`                |
| `isLoading`   | `Bool`                 |

#### Public Key VM
| Property      | Type                   |
|---------------|------------------------|
| `publicKey`   | `PresentablePublicKey` |
| `error`       | `Error`                |
| `isLoading`   | `Bool`                 |

#### Private Key VM
| Property      | Type                   |
|---------------|------------------------|
| `privateKey`  | `PresentablePrivateKey`|
| `error`       | `Error`                |
| `isLoading`   | `Bool`                 |

#### Balance VM
| Property      | Type                   |
|---------------|------------------------|
| `balance`     | `PresentableBalance`   |
| `error`       | `Error`                |
| `isLoading`   | `Bool`                 |

#### Transaction
| Property      | Type                    |
|---------------|-------------------------|
| `transaction` | `PresentableTransaction`|
| `error`       | `Error`                 |
| `isLoading`   | `Bool`                  |

#### Asset VM
| Property      | Type                   |
|---------------|------------------------|
| `asset`       | `PresentableAsset`     |
| `error`       | `Error`                |
| `isLoading`   | `Bool`                 |

#### Wallet VM
| Property      | Type                   |
|---------------|------------------------|
| `wallet`      | `PresentableWallet`    |
| `error`       | `Error`                |
| `isLoading`   | `Bool`                 |

----------------

#### Onboarding screen

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/CreationOptions.jpg?raw=true)

----------------

#### Seed Phrase screen

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/SeedListGIF_AdobeExpress.gif?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/SeedListScreen.jpg?raw=true)

----------------

#### Wallet List screen

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/WalletListGIF_AdobeExpress.gif?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/WalletListScreen.jpg?raw=true)

----------------

#### Wallet screen

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/WalletViewGIF_AdobeExpress.gif?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/WalletScreen.jpg?raw=true)

----------------

#### Transaction List screen

![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/GIFs/TransactionListGIF_AdobeExpress.gif?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/TXsScreen.jpg?raw=true)

#### Transaction Detail screen

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/TXAPI.jpg?raw=true)

## Get Balance BDD Specs (Under Maintenance)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/WalletBalanceView.jpg?raw=true)

![Alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaSwiftSDK/Media/Screens/BalanceView.jpg?raw=true)

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

### Viewing the Project

This project is available for viewing directly on GitHub. Please note, the software and its contents are restricted for viewing only and may not be cloned, downloaded, or used in any form outside of the GitHub interface.

### License

This repository is governed by a custom license that restricts use, cloning, downloading, and redistribution. Modifications to the software are permitted only by collaborators who have been explicitly authorized in writing by Deniz Tutuncu. For full license details, see the [LICENSE.md](LICENSE.md) file.

### Automated Processes

#### GitHub Actions
GitHub Actions are configured to automate the build and testing process for this project. These actions are triggered by activities performed by authorized collaborators:
- **Build and Test**: Automated scripts run for both macOS and iOS platforms when changes are made by authorized collaborators to specific branches. The process includes checking out the code, installing necessary profiles and certificates, and selecting the appropriate version of Xcode.
- **Continuous Integration**: The project employs two scripts, `CI_macOS` and `CI_iOS`, to build the software and run tests under specified destination settings.
- **Continuous Deployment**: The `Deploy` script is responsible for automated deployment on App Store Connect following changes to the main branch by authorized collaborators.

#### Contribution Guidelines

Due to the restrictive licensing of this repository, contributions in the form of code modifications are not accepted unless the contributor is an authorized collaborator. For those authorized, changes should be committed to a designated development branch and submitted via pull request (PR) for review.

### Continuous Integration and Deployment

Detailed processes for Continuous Integration (CI) and Continuous Deployment (CD) are designed to ensure the highest standards of quality and functionality, exclusively managed by the project's maintainers.

For any inquiries or to request authorization for collaboration, please contact Deniz Tutuncu directly.
