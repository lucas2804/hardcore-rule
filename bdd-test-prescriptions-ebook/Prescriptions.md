#### Prescription 1(Soso)

- Use the TDD process to create and adjust your code's design in small, incremental steps.

#### Prescription 2(Good)

In a TDD process, If it is difficult to write tests for a feature, 
Strongly consider the possibility that the underlying code needs to be changed.


#### Prescription 4(Good)

When possible, write your tests to describe your code's behavior, not its implementation

#### Prescription 5(Good)

- Keeping your code as simple as possible allows you to focus complexity on the areas that really need complexity

#### Prescription 6(Good)

- Choose your test data and test-variable names to make it easy to diagnose failures when thay happen. Meaningful names and data that doesn't overlap are helpful.

#### **I prefer to do failure testing in unit tests rather than end-to-end tests(page 68)**

#### Prescription 7(Good)

- Test isolation makes it easier to understand test failures by limiting the scope of potential locations where the failure might have occurred.
 
- Mine: Something like, happen error on website we will look at **model tests** or **another tests** instead of looking at **controller tests**.

#### Prescription 9

- If you find yourself writing tests that already pass given the current state of the code, that often means you're writing to much code in each pass.

#### Prescription 10

- Refactoring is where a lot of design happens in TDD, and it's easiest to do in small steps, Never skip it.

#### Prescription 11(Best)

- Try to extract methods when you see compound Booleans, local variables, or inline comments.

- You'll be surprised at how much more flexible your code feels if you minimize the number of local variables in methods.
