# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

# Uploading the webpage

def crypto_scrapper
  result = []
  begin
  page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  page.xpath('//*[@id="currencies-all"]/tbody/tr').each do |row|
    begin
      hash = {}
      hash[row.css('td.col-symbol').text] = \
        row.css('td a.price').text[1..-1].to_f
      # Take only Crypto that have a definite value
      result << hash if hash[hash.keys[0]] != 0
    rescue NoMethodError => e
      puts "Xpath may be wrong. Check the Coin Market Website and adapt it."
    end
  end

  result
  rescue Errno::ENOENT => e
    puts "URL Name of Coin Market Not Found"
  end
end

p crypto_scrapper
