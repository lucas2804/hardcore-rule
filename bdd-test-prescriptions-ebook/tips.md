```
When possible, write your test to describe your code's behavior, not its implementation.
```

```
    Keeping your code as simple as possible 
```

```
    Remove logic from controllers and views
    However, by moving logic outside the controller and the views themselves, we can turn those slower and more fragile middle-ground tests into faster and more robust unit tests.
```

```
    Create a class to encapsulate the logic and workflow. This tends to be my first choice these days
    ...
    The main downside is you wind up with a lot of little classes, but I don’t mind having a lot of little pieces anyway.
```