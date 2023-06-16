require 'csv'

class Exch
  ECB_RATES_URL = 'https://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv'.freeze

  RATES_CSV_FILENAME = Rails.root.join('public/rates.csv').freeze

  CSV_HEADERS = %w[rate_period rate_value].freeze

  def self.get_rates
    uri = URI(ECB_RATES_URL)
    response = Net::HTTP.get(uri)

    new.save_rates_to_file(response)
  end

  def self.exchange(amount, period)
    period = new.parse_date period
    rates = Rate.find_by_period(period).pluck(:rate_value)
    rates.to_a.map{ |r| ('%.2f' % (r * amount)).to_f }
  end

  def save_rates_to_file(resp)
    File.open(RATES_CSV_FILENAME,'w') do |f|
      f.write resp
    end

    save_rates_to_db
  end

  def clear_rates
  	Rate.delete_all
  end

  def save_rates_to_db
		clear_rates    

    CSV.foreach(RATES_CSV_FILENAME, headers: CSV_HEADERS).drop(6).each do |row|
      attrs = row.to_h.slice(*CSV_HEADERS)
      Rate.create(attrs)
    end
  end

  def parse_date(date)
    if date.is_a?(Array)
      date.map(&:to_s)
    else
      date.to_s.lines.to_a
    end
  end
end
