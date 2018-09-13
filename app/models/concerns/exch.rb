require 'csv'

module Exch
  extend self

  def ecb_rates_url
    'https://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv'
  end

  def rates_csv_file
    Rails.root.join('public/rates.csv')
  end

  def csv_header_names
    %w[rate_period rate_value]
  end

  def get_rates
    uri = URI(ecb_rates_url)
    response = Net::HTTP.get(uri)
    save_rates_to_file response
  end

  def save_rates_to_file(resp)
    File.open(rates_csv_file,'w') do |f|
      f.write resp
    end
    save_rates_to_db
  end

  def save_rates_to_db
    Rate.delete_all
    CSV.foreach(rates_csv_file, headers: csv_header_names).drop(5).each do |row|
      Rate.create(row.to_h)
    end
  end

  def parse_date(date)
    if date.is_a?(Array)
      date.map(&:to_s)
    else
      date.to_s.lines.to_a
    end
  end

  def exchange(amount, period)
    period = parse_date period
    rates = Rate.find_by_period(period).pluck(:rate_value)
    rates.to_a.map{ |r| ('%.2f' % (r * amount)).to_f }
  end
end