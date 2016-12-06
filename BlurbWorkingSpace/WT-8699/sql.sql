ALTER USER "user_name" WITH PASSWORD 'Rainsilent2804';


SELECT * FROM blurb_production.blurby.sellers WHERE id = 84415;

SELECT seller_id, period_id, author_profit, carry_over_amount, statements.created_at FROM sellers JOIN statements ON sellers.id = statements.seller_id WHERE sellers.id = 181447 ORDER BY created_at DESC ;
SELECT COUNT(*) FROM sellers JOIN statements ON sellers.id = statements.seller_id WHERE sellers.id = 181447;


SELECT id, author_markup_usd, created_at FROM blurb_production.blurby.markups WHERE author_markup_usd < 0;

SELECT COUNT(*) FROM blurb_production.blurby.markups WHERE author_markup_usd < 0;

SELECT * FROM blurb_production.blurby.markups WHERE author_markup < 0 AND markupable_id = 3760511 AND markups.markupable_type = 'SellerBookSpecification';

SELECT * FROM blurby.markups JOIN blurby.markup_histories ON markups.id = markup_histories.markup_id WHERE markups.id IN (4227316,4227317,4227255,4227256,4227257,4227321,4227322,4227323,4227307,4227308,4227309,4227240,4227241,4227242,4227262,4227263,4227264);

SELECT * FROM blurby.markups RIGHT OUTER JOIN blurby.markup_histories ON markups.id = markup_histories.markup_id WHERE markups.id IN (18597,18598,18590) ORDER BY markup_id, markup_histories.created_at ASC;

SELECT * FROM blurby.markups WHERE markups.id IN (4227316,4227317,4227255,4227256,4227257,4227321,4227322,4227323,4227307,4227308,4227309,4227240,4227241,4227242,4227262,4227263,4227264, 18597,18598,18590);

SELECT * FROM seller_book_specifications WHERE id = 3760439;

SELECT * FROM blurby.markup_histories WHERE markup_histories.markup_id IN (18597,18598,18590) ORDER BY markup_id, created_at ASC ;

SELECT * FROM markups WHERE id IN (18597,18598,18590) ORDER BY  created_at ASC;

SELECT * FROM blurby.markup_histories WHERE markup_histories.markup_id IN (4227316,4227317,4227255,4227256,4227257,4227321,4227322,4227323,4227307,4227308,4227309,4227240,4227241,4227242,4227262,4227263,4227264) ORDER BY markup_id, created_at ASC ;

SELECT COUNT(*) FROM markups  WHERE author_markup < 0;a
SELECT COUNT(*) FROM markups  WHERE author_markup_usd = 0;
SELECT COUNT(*) FROM markups  WHERE author_markup_usd > 0;

SELECT * FROM blurb_production.blurby.markup_histories  WHERE markup_id = 4227317;

SELECT * FROM distribution_entries WHERE  seller_book_specification_id = 3760511;
SELECT * FROM distribution_entries WHERE  project_format_id IN (12783930, 12783929, 12783928);
SELECT * FROM project_formats WHERE  project_id = 7566030;
SELECT * FROM project_format_types;
SELECT * FROM isbns WHERE id IN (311445, 311446);

SELECT COUNT(*), currency_id FROM markups WHERE author_markup_usd < 0 AND author_markup >= 0 GROUP BY currency_id;

SELECT * FROM markups WHERE author_markup_usd < 0 AND author_markup >= 0;
SELECT COUNT(*), currency_id FROM markups WHERE author_markup_usd < 0 GROUP BY currency_id;
SELECT * FROM markups WHERE id = 4227317;

4227316,4227317,4227255,4227256,4227257,4227321,4227322,4227323,4227307,4227308,4227309,4227240,4227241,4227242,4227262,4227263,4227264


SELECT * FROM distribution_entries  WHERE project_format_id IN (12738322, 12738323, 12738325);

SELECT * FROM markups WHERE markupable_id=4604291;
SELECT * FROM markups WHERE markupable_id IN (4604290, 4604291);

SELECT * FROM markups ORDER BY markupable_id DESC;

SELECT * FROM markups JOIN  markup_histories ON markups.id = markup_histories.markup_id WHERE markupable_id IN (4604290, 4604291);


SELECT * FROM line_items WHERE price < 0;
SELECT count(*) FROM line_items WHERE price < 0;
SELECT count(*) FROM line_items WHERE price_usd < 0;
