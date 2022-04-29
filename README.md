# SolanaPackage

## BDD Specs

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

## Use Cases

### Load Balance From Remote Use Case
