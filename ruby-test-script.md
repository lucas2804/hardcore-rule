##Thread in Ruby

```ruby
t1 = Thread.new do
  begin
  puts 'Hello'
  raise Exception
  
  rescue Exception => e
    puts e.backtrace
  end
end

t2 = Thread.new do
  puts 'Hello from the other thread'
end

puts 'The End'


t1 = Thread.new do
  puts "print first"
  raise "Oh no!"
  puts "This will never print"
end

begin
    t1.status # nil, indicating an exception occurred
    t1.join
rescue => e
    puts "Thread raised #{e.class}: #{e.message}"
end
```