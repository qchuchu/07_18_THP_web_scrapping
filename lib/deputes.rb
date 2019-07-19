# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'pry'

def get_deputy_info(deputy_url)
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr#{deputy_url}"))
  names = page.css('div.titre-bandeau-bleu h1').text.split(' ')[1..-1]
  hash = {}
  hash['first_name'] = names[0]
  hash['last_name'] = names[1..-1].join(' ')
  begin
    path = '//a[@class="email"]'
    hash['email'] = page.xpath(path).first['href'].gsub('mailto:','')
  rescue NoMethodError => e
    puts "#{names.join(' ')} n'a pas d'email!"
    hash['email'] = ""
  end
  hash
end

def get_deputy_url
  page = Nokogiri::HTML(open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  array = []
  links = page.xpath('//a[starts-with(@href,"/deputes/fiche/")]')
  links.each do |el|
    array << el['href']
  end

  array
end

def perform
  array = []
  deputy_urls = get_deputy_url
  deputy_urls.each_with_index do |url, i|
    puts "#{i + 1}/#{deputy_urls.length} députés checkés !"
    array << get_deputy_info(url)
  end

  array
end

p perform
