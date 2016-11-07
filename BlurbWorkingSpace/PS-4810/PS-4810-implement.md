###Ashley Caputo added a comment - 7 hours ago
Luc Dang We had a second case of this come up where an ISBN was still showing as related to a book and I think you're right that it has to do with replacing a number.

```
 Could we prevent replace isbn function if this book was existed on amazon. (As we've prevented replace isbn function if this book was existed on ingram) ?
```  

1) From a CS perspective, I would like if the swap or replace ISBN function was disabled if the book was for sale with either Ingram or Amazon.


```
Could we remove the book on amazon when isbn was replaced by admin?
```
2) That is what we should be doing, but I much prefer just not being able to do it if the book is currently in Amazon.

- Is there a way to not destroy the ISBN, but to show it as a number that was once used in our system? That would help us for historical knowledge relating to a specific ISBN that was ever assigned or used in our system.

###Implement

####1) disabled the book was for sale on Amazon(Ingram)


####2) As solution 1, not being able to do it if the is currently in Amazon

####3) QnA: Currently we do not track history of ISBN

- 17/8/2016 10:09:13.000 +0700 Book004 submit to Amazon <PublicationDate>2016-08-16T16:33:23</PublicationDate>
project-format-id: 12330701
![time-create-004](./images/wt4810/time-create-004.png)

- 17/08/2016 16:51:46.000 +0700 Book004 was replaced by isbn003

- 17/09/2016 01:20:24.000 +0700 Book003 submit to Amazon <PublicationDate>2016-08-16T16:33:23</PublicationDate>
project-format-id: 12330701 (2016-08-16 19:47:19 INFO Attempting to assign isbn with number_text 9781367351004 to guts 7762272, cover_design 7858365, cover_type 6)
![time-create-003](./images/wt4810/time-create-003.png)



###Reproduce 9781366877529

- SubmitFeed Amazon 9781366877529 07/11/2016 15:39:07.000 +0700 
![29-feed-product-list.png](./images/wt4810/29-feed-product-list.png)

- 9781366877499 replace 9781366877529 on amazon
![529-on-amazon-01.png](./images/wt4810/529-on-amazon-01.png)
![529-on-amazon-02.png](./images/wt4810/529-on-amazon-02.png)
![499-replace-529.png](./images/wt4810/499-replace-529.png)


- SubmitFeed Amazon 9781366877499 07/11/2016 16:32:06.000 +0700

![499-feed-product-list.png](./images/wt4810/499-feed-product-list.png)

![499-529-duplicate-on-amazon.png](./images/wt4810/499-529-duplicate-on-amazon.png)


###Remove Product by Remove distribution_entries (9781366877581)

![81-amazon-removed.png](./images/wt4810/81-amazon-removed.png)

![81-amazon-removed-02.png](./images/wt4810/81-amazon-removed-02.png)

![81-amazon-removed03.png](./images/wt4810/81-amazon-removed03.png)


####Re-feed 9781366877581 with 9781366877352 9781366877529

![81-re-feed-amazon.png](./images/wt4810/81-re-feed-amazon.png)

![81-re-feed-xml02.png](./images/wt4810/81-re-feed-xml02.png)

![81-re-feed-01.png](./images/wt4810/81-re-feed-01.png)
