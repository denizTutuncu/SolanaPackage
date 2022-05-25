# SolanaPackage

## User Flow
![alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaiOS/Diagrams/UserFlow.jpg?raw=true)

```
1- Create Wallet
2- Receive Sol (in progress)
3- Display past transactions
4- Send Sol
```

![alt text](https://github.com/denizTutuncu/SolanaPackage/blob/main/SolanaiOS/Diagrams/SOLiOSSDK.jpg?raw=true)

## Create Wallet BDD Specs

### Create Wallet
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
    And the seed phrase 
```

## Model Specs

### Seed

| Property      | Type                |
|---------------|---------------------|
| `seed`        | `[String]`          |


----------------

## Get Balance BDD Specs

### Get Balance / Receive Sol
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
```

## Model Specs

### Balance Response

| Property      | Type                |
|---------------|---------------------|
| `jsonrpc`     | `String`            |
| `result`      | `BalanceResult`     |
| `id`          | `String`            |

### Balance Result
| Property      | Type                |
|---------------|---------------------|
| `context`     | `BalanceContext`    |
| `value`       | `Int`               |
| `id`          | `String`            |

### Balance Context
| Property      | Type                |
|---------------|---------------------|
| `slot`        | `Int`               |

-----------------

Still working on the specs. Thank you for your understanding and please feel free to conncet with me and/or contribute to the project.
