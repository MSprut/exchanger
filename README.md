# README

##### * Ruby and Rails
Ruby 3.1.4
Rails 7.0.4


##### * Database creation and initialization
Before manipulation with database rename the files database.example.yml and secrets.example.yml in /config directory to database.yml and secrets.yml respectively. Then edit your database.yml with actual DB "username" and "password" values. Then execute "rake db:create db:migrate" in terminal inside app folder.


##### * How to run the test suite
Run test with 'rspec spec/exch_spec.rb' command in terminal inside app directory.

##### * How to run with docker
```
	docker-compose up --build
	docker-compose run web rails db:create db:migrate
	docker-compose run web bundle exec rails c
```

In case you get the DB collation version mismatch error:

```
	docker exec -it -u postgres <db_container_name> psql
	ALTER DATABASE postgres REFRESH COLLATION VERSION;
```

##### * How to work
After installation and initialization of the application with or without Docker run the Rails console. Then using the `Exch.get_rates` command you can get USD/EUR rates from ECB site. This will get the rates in CSV format from ECB site, save it to CSV-file and then save rates to DB. After that you can exchange USD to EUR for specified date or date range.
For this you should use the `Exch.exchange(amount, date)` or `Exch.exchange(amount, [date1, date2])` commands where 'amount' is the amount of USD will to be converted to EUR, 'date or [date1, date2]' - the date or date range. Date format should be in Ruby Date class format, for example, Date.yesterday, [Date.yesterday - 1.month, Date.yesterday - 1.week] etc. 
