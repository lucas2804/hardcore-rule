####Puts 
```ruby
begin    
seller = Seller.find 181447
seller.update_currency_and_exchange_markups!
rescue StandardError => standard_error 
puts "Accountant -- Error updating seller currencies for seller_ids #{standard_error.message}"
end   
````

```ruby
seller = Seller.find 181447
seller.update_currency_and_exchange_markups!

seller.user.books.map(&:markups).flatten.each do |markup|
      puts markup.id
      currency = Currency.euro
      markup.exchange_to!(currency)
end
    
m = Markup.find 4227315
m = Markup.find 4227316
m.exchange_to!(Currency.cad)    
m.author_markup.exchange_to(Currency.euro)
m.markupable.distribution_entry.book

seller = Seller.find 181447
seller.currency = Currency.find_by_iso_id "CAD"
seller.queued_currency_id = "USD"

begin
    new_curr = Currency.find_by_iso_id "USD"
    old_curr = seller.currency
    seller.currency = new_curr
    # seller.queued_currency = nil
    seller.save!
     
    seller.exchange_markups!(old_curr, new_curr)
    seller.exchange_list_prices!
rescue StandardError => standard_error
    puts "#{standard_error.message}"
    puts "#{standard_error.to_json}"
end

# 84415, 105585, 181447
seller = Seller.find 105585
#exchange_ebook_markups!
seller.user.books.map(&:markups).flatten.each do |markup|
    begin
      currency = Currency.find_by_iso_id "USD"
      markup.exchange_to!(currency)
    rescue StandardError => standard_error
        # puts "#{standard_error.message}"
        # puts "#{standard_error.to_json}"
        puts markup.id
    end
end

#exchange_book_markups!
seller.user.ebooks.each do |ebook|
    begin
      new_curr = Currency.find_by_iso_id "USD"
      old_curr = seller.currency
      if ebook.for_sale?
        if ebook.markup.present?
            tier = ebook.exchanged_to_tier(old_curr, new_curr)
            ebook.update_attribute(:price_tier, tier)
        end

        # we only support submission in USD. if they are changing their currency
        # then we want to remove it from the iBooks Store
        ebook.remove_from_ibookstore! if ebook.on_ibookstore?
      end    
    rescue StandardError => standard_error
        puts "#{standard_error.message}"
        puts "#{standard_error.to_json}"
    end
end

#exchange_list_prices!
entries = seller.user.books.map(&:distribution_entries).flatten
entries.each do  |entry|
 begin
    currency = Currency.find_by_iso_id "USD"
    entry.exchange_to!(currency) unless entry.none?
 rescue StandardError => standard_error
     puts "#{standard_error.message}"
 end  
end

```

###Why author_markup was negative.

2) View markup_history and markup, check_created_at
    - Get list markup_id, no markup_histories
    - 84415 , 105585 - 3 markup histories, 181447 - no markup_histories
1) Try to make author_markup negative
3) Check log git to compare code
    - rollback to 2012 markup.rb and still not create negative number.
4) Reproduce on vagrant_server: try to make author_markup be negative
    - rollback to 2012 markup.rb and still not create negative number.
5) Check code where log tell this markup change to negative.

```ruby
@ebook = Ebook::Ebook.find 1
markup = Money.new(-10, Currency.usd)
markup = Markup.create :markupable => @ebook, :author_markup => markup

markup = Markup.find 4227316
markup.exchange_to(Currency.usd)

negative_money = Money.new(0, Currency.cad, -342) #Can not, cause author_markup_usd is 1
negative_money = Money.new(-400, Currency.usd) #Can not

negative_money = Money.new(0, Currency.usd, -245) #Sure
ebook = Ebook::Ebook.find 1
fail_markup = Markup.create(:author_markup => negative_money,  :markupable => ebook)
fail_markup.save
fail_markup.author_markup = fail_markup.author_markup.exchange_to(Currency.cad)
fail_markup.save
fail_markup.errors

fail_markup = Markup.create(:author_markup => negative_money, :author_markup_usd => negative_money, :markupable => ebook)


reset_author_profit_usd
```
###SSH Info
- WS - The same environment with PROD Link: http://ws.blurb.com/
- ssh tle@oak-stage-worker01
- psql -h  oak-stage-db01.blurb.com -U blurby  -d blurb_staging
(MASTER: ssh tle@hq-master-worker01.eng.blurb.com)
sudo su - blurbapp
cd $PROJ
script/console
bundle exec rake finance:accountant:calculate
