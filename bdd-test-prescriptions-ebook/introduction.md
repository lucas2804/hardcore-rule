**You want to focus "What's an object is???" or "What does object do???"**

```In scope of BDD test, "What does object do" is more significantly. And customers focus on "What does object do" ```

- Cause developer too noob in communication so code is the best document and test still is the best document too -> So BDD
Example: _**Given**_ some context, _**When**_ some event occurs, _**Then**_ I expect some outcome.

**Build your code under test cover**
- Take a list of the test cases before to void duplicate test cases.
- Write fail test first -> write very simple code to pass -> refactor -> red -> green -> refactor...
- _Minimal side effect_: One method just only does one thing.
- High cohesion: code in the same unit is all related.
- If some features really difficult to write tests, it often means your codebase is too interdependent.

- step1 Test always right, step2 If test maybe wrong -> just rollback step1 ahihi đồ ngok
 
 **SCOPE**
 
- write test error conditions EVEN they are already covered in code, absolutely.
- write test valid context EVEN they are already covered in code, should not be ignored

- ??? Test doubles: some features depending on "Third party or external" really hard to isolate -> Using Mocks and Stubs

**DO NOT WRONG ASSUME**

- TDD is good, right?
- But still not be able to replace acceptance testing from QA.
- But won't solve all of your development problems.

```The purpose of testing is to verify that my program is correct. I can never prove correctness with 100 percent certainty. Therefore, testing has no value. BDD to combat this attitude ```

```Some fun: I think that BDD will be a revolution as OOP, FP. It will be ROP(Release Oriented Programing) ```






