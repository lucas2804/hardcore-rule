###Ember Change State

- By default, **computed** properties **observe** any changes made to their properties.

```javascript
# description: .......property('firstName', 'age')
# => description observe the change of firstName, age.
captainAmerica.set('firstName', 'William')
captainAmerica.get('description'); //"William Rogers; Ag: 80 ...
```


```



