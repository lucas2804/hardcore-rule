####Integration Testing

- An integration is named for combines more than one unit.

**1 - Should be used**:
- Between controller and model(Or other objects that provide data)
- Between controller actions and controller actions(test workflow)

**2 - Should not be used**

- What happens if data is nil or has an unexpected value.
- Internal implementation details of business logic

####Acceptance test

- Acceptance test is an integration test combines with integration test


####Controller test

- Unlike end-to-end test, controller testing does not got through entire Rails stack.

####Test UI

- In Rails, controller and view instance are not easy to create in isolation during test.

```html
Controller and view calls often are more interesting for their side effects than for the value they return
-> Controller-View often too large to be meaningfully unit-tested.
```

- Because the complicated functionality is in models or other objects are being tested in your unit tests.
- **Best practice**: Test models are easier to test than controllers because
 1) Model ez to extract, be able use independently in a test framework.


#### What to test in a Controller Test

- Verifying normal workflow: 
     - basic user request
     - triggers expected model 
     - and 3 passes data to view.

- Verifying 
     - invalid user request is handled right.

- Verifying security

```html
A controller test should test controller behavior. A controller test should not fail because of problems in the model.
```

#### Testing Helper Methods

- **Helper modules** are designed to contain:
1) reusable bits of view logic.
2) conditional logic  of how content is displayed.

```html
Helper methods often aren’t tested even when they contain significant amounts of logic.
```



