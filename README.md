# README

##### * Ruby and Rails version
Ruby 2.5.1
Rails 5.1.6


##### * Database creation and initialization
Before manipulation with database rename the files database.example.yml and secrets.example.yml in /config directory to database.yml and secrets.yml respectively. Then edit your database.yml with actual DB "username" and "password" values. Then execute "rake db:create db:migrate" in terminal inside app folder.


##### * How to run the test suite
Run test with 'rspec spec/exch_spec.rb' command in terminal inside app directory.


##### * How to work
After installation and initialization of the application run the Rails console with "rails c" through terminal in app directory. Then using the 'Exch.get_rates' command you can get USD/EUR rates from ECB site. This will get the rates in CSV format from ECB site, save it to CSV-file in 'public' directory and then save rates to database. After that you can exchange USD to EUR for specified date or date range. For this you should use the 'Exch.exchange(amount, date)' or 'Exch.exchange(amount, [date1, date2])' commands where 'amount' is the amount of USD will to be converted to EUR, 'date, date1, date2' - the date or date period. Date format should be in Ruby Date class format, for example, Date.today, [Date.today-1.month, Date.today-1.week] etc. 
