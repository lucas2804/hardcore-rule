SELECT * FROM project_formats WHERE id = 3490855;

SELECT * FROM distribution_entries WHERE id = 864375;
SELECT * FROM distribution_list_prices WHERE id = 864374;
SELECT * FROM distribution_list_price_histories WHERE distribution_list_price_id = 864374;
SELECT * FROM distribution_channels WHERE id = 4;
SELECT * FROM seller_book_specifications WHERE id = 1003286;
SELECT * FROM markup_histories JOIN markups ON markup_histories.markup_id = markups.id WHERE markups.markupable_id = 1003286;

SELECT * FROM cover_designs WHERE id = 2670456;
SELECT product_id, price, initial_price, created_at, updated_at, id FROM line_items WHERE product_id = 2461356 ORDER BY id ASC ;

SELECT * FROM markups WHERE markupable_id = 1003286;

SELECT * FROM markups WHERE markupable_id = 1003286;

SELECT * FROM product_options;

SELECT * FROM base_prices WHERE cover_type_id = 2 AND updated_at > '2015-11-05';


SELECT count(*) FROM line_items;

SELECT count(*) FROM line_items WHERE created_at IS NULL;


SELECT li.price, li.initial_price, ppo.created_at, ppo.updated_at, id FROM line_items AS li JOIN purchased_product_options AS ppo ON li.id = ppo.line_item_id WHERE li.product_id = 2461356 ORDER BY id ASC ;


####################

SELECT seller_book_specification_id FROM distribution_entries WHERE id = 1528847;
SELECT cover_design_id FROM seller_book_specifications WHERE id = 4649202;
SELECT product_id FROM cover_designs WHERE id = 8154666;
SELECT * FROM line_items WHERE product_id = 7560106;

SELECT * FROM distribution_entries JOIN seller_book_specifications JOIN cover_designs JOIN line_items
  ON distribution_entries.seller_book_specification_id = seller_book_specifications.id ON seller_book_specifications.cover_design_id = cover_designs.id ON line_items.product_id = cover_designs.product_id WHERE distribution_entries.id = 1528847;

SELECT * FROM distribution_entries JOIN seller_book_specifications  ON distribution_entries.seller_book_specification_id = seller_book_specifications.id JOIN cover_designs ON seller_book_specifications.cover_design_id = cover_designs.id JOIN line_items ON line_items.product_id = cover_designs.product_id WHERE distribution_entries.id = 864375;

SELECT cover_designs.product_id FROM distribution_entries JOIN seller_book_specifications  ON distribution_entries.seller_book_specification_id = seller_book_specifications.id JOIN cover_designs ON seller_book_specifications.cover_design_id = cover_designs.id WHERE distribution_entries.id = 1504234;

SELECT * FROM line_items WHERE isbn_id = 309399;

SELECT id FROM isbns WHERE number_text = '9781366780225';



SELECT seller_book_specification_id, paper_type_id, line_items.* FROM distribution_entries JOIN seller_book_specifications  ON distribution_entries.seller_book_specification_id = seller_book_specifications.id JOIN cover_designs ON seller_book_specifications.cover_design_id = cover_designs.id JOIN line_items ON line_items.product_id = cover_designs.product_id WHERE distribution_entries.id = 864375;


SELECT * FROM seller_book_specifications WHERE id = 1003286;
SELECT * FROM distribution_entries WHERE id = 864375;
SELECT * FROM project_formats WHERE id = 3490857;
SELECT * FROM projects WHERE id = 2461356;




SELECT * FROM base_prices WHERE  EXTRACT(year FROM "created_at") = 2016 ;
SELECT created_at, cover_type_id, price, currency_id FROM base_prices WHERE  EXTRACT(year FROM "created_at") = 2016 AND cover_type_id = 2 ORDER BY created_at;

SELECT * FROM base_prices WHERE  EXTRACT(year FROM "created_at") = 2016 ;
SELECT created_at, cover_type_id, price, currency_id FROM base_prices WHERE  cover_type_id = 2 AND currency_id = 'USD' ORDER BY created_at DESC LIMIT 3;


SELECT * FROM base_prices WHERE  cover_type_id = 2;
SELECT * FROM page_prices WHERE  EXTRACT(year FROM "created_at") = 2016 AND paper_type_id = 10;

SELECT count(*), cover_type_id FROM base_prices GROUP BY cover_type_id;

























