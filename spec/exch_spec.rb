require 'rails_helper'

RSpec.describe Exch do

  it 'should return url for download ecb rates' do
    expect(Exch.ecb_rates_url).to eq('https://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv'
)
  end

  it 'should return path to csv file' do
    expect(Exch.rates_csv_file).to eq(Rails.root.join('public/rates.csv'))
  end

  it 'should return new csv headers' do
    expect(Exch.csv_header_names).to eq(%w[rate_period rate_value])
  end

  it 'should return array of string with one date' do
    expect(Exch.parse_date(Date.today)).to eq([Date.today.strftime('%Y-%m-%d')])
  end

  it 'should return array of string with two date' do
    expect(Exch.parse_date([Date.yesterday, Date.today])).to eq([Date.yesterday.strftime('%Y-%m-%d'), Date.today.strftime('%Y-%m-%d')])
  end
end