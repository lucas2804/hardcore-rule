- books_controller.rb#show -> book_lookup.rb#validate_token
- bookstore_controller#detail add invited to preview_link (http://www.blurb.com/bookstore/invited/6770254/fc577c65e120eb3aabb52a26733797446d724957)

- _responsive_preview_price_detail.html.haml

- Depend on Proposed solution: The "book preview" link should also be an "invite" link so that when the user copies and pastes it to Facebook it works.
 1) change 

####Bookshare - Root cause: User should be accessed to invite_link first then access to preview_link to let browser remember the cookies to authenticate.
```html
Currently there's a problem where a user can share a bookshare preview link from an "invite" bookstore page link and Facebook is not able to display the information. Here are the repro steps:
1) User A has a book that's "invite only"
2) User A shares the invite link with user B
3) User B follows the link
  - invite_link looks like this "http://www.blurb.com/books/7656982-bookify"
4) User B clicks on "preview book" (under the cover) 
  - preview_link looks like this http://www.blurb.com/books/7656982-bookify
5) User B gets the url from that page and posts it to Facebook

Root cause: User should be accessed to invite_link first then access to preview_link to let browser remember the cookies to authenticate.

Expected: Facebook correctly grabs the information on the page
Actual: Facebook is redirected to user A's profile page and grabs that information
Proposed solution: The "book preview" link should also be an "invite" link so that when the user copies and pastes it to Facebook it works.
```