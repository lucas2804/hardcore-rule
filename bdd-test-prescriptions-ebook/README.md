#I - Introduction
####[Chapter2-TDD-Basics](./2-TDD-Basics.md)
####[Chapter3-TDD-in-Rails](./3-TDD-in-Rails.md)
####[Chapter4-What-Makes-Greate-Tests](./4-What-Makes-Greate-Tests.md)
####[Chapter5-0-Testing-Models](./5-0-Testing-Models.md)
####[Chapter5-1-Testing-Model-in-Rails](./5-1-Testing-Model-in-Rails.md)

##About the gains

- In a strict TDD process, new logic is added to the program only after a failing test is written to prompt the creation of the logic.

- About the gains when verify: Cause running the automation test is faster than verifying in the browser -> you will gain a little bit each try.
- About the gains when refactor: have to switch to browser and blablabla.
- When verify and refactor will run all isolate test without forget any testcase.

- It's pretty bored when you have to switch to browser and verify, trust me it's really bored.

##II - Testing First Drives Design

###1 - Steps to success with TDD(page 15)

1) Create a test. The test should be short and test for one thing in your code. The test should run automatically.

2) Make sure the test fails. Verifying the test failure before you write code helps ensure that the test really does what you expect

3) Write the simplest code that could possibly make the test pass. Don't worry about good code yet. Sometimes, write just enough code to clear the current error.

4) After the test passes, refactor to improve the code. Clean up duplication. Optimize. Create new abstractions. Refactoring is a key part of design, so don't skip this. Remember to run the tests agian to make sure you haven'y changed any behavior
=> REPEAT UNTIL DONE.

###Prescription1 in Prescriptions.md
###Prescription2

##III - Behavior-driven development (BDD)

- The purpose of testing is: "to verify that my program is correct. I can never prove correctness with 100% percent certainty. Therefor, testing has no value" (Behavior-driven development and RSpec were created to combat this attitude)
