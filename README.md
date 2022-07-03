# SolanaPackage

#### Solana Package connects OS platforms to Solana Blockchain.
#### The package provides a software to any OS developers. It can be used to create a valid Solana wallet on any OS applications - macOS, iOS, watchOS, etc.
#### This gives the ability to interact with Solana Blockchain and receive/send Sol. 
 
## User Flow
![alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaiOS/Diagrams/UserFlow.jpg?raw=true)

```
1- Create Wallet / Receive Sol (in the future)
2- Display balance (in progress, component is ready to review)
3- Display past transactions (in progress)
4- Send Sol (in the future)
```

### Prototype
![Alt Text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaiOS/Diagrams/PROTOTYPEIOS_AdobeCreativeCloudExpress.gif)

----------------

![alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaiOS/Diagrams/SOLiOSSDK.jpg?raw=true)

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

## Get Balance BDD Specs (in progress, ready to review on MySolWallet iOS app)

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
| `lamports`        | `Int`             |

### UI Model
#### Balance UI Model
| Property      | Type                  |
|---------------|-----------------------|
| `balance`        | `Balance`          |
| `error`          | `Error`            |
| `isLoading`      | `Bool`             |



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
